from smoothdrive.domain.models import Coordinate, Route
from smoothdrive.services.overpass import build_corridor_query, chunk_polyline, parse_response
from smoothdrive.services.geometry import haversine_m

SAMPLE_RESPONSE = {
    "elements": [
        {
            "type": "way",
            "id": 1,
            "tags": {"highway": "primary", "maxspeed": "40 mph"},
            "geometry": [
                {"lat": 51.50, "lon": -0.10},
                {"lat": 51.51, "lon": -0.11},
            ],
        },
        {
            "type": "way",
            "id": 2,
            "tags": {"highway": "primary"},
            # Degenerate single-point geometry must be dropped
            "geometry": [{"lat": 51.50, "lon": -0.10}],
        },
        {
            "type": "node",
            "id": 3,
            "tags": {"highway": "traffic_signals"},
            "lat": 51.505,
            "lon": -0.105,
        },
    ]
}


def _route() -> Route:
    return Route(
        geometry=[Coordinate(lat=51.50, lon=-0.10), Coordinate(lat=51.51, lon=-0.11)],
        distance_meters=1000,
    )


def test_build_corridor_query_contains_filters() -> None:
    query = build_corridor_query(_route().geometry, corridor_width_m=25)
    assert "around:25" in query
    assert "traffic_signals" in query
    assert "highway" in query
    assert "out body geom;" in query
    assert "51.500000,-0.100000" in query


def test_parse_response_splits_ways_and_nodes() -> None:
    corridor = parse_response(SAMPLE_RESPONSE)
    assert len(corridor.ways) == 1
    assert corridor.ways[0].tags["maxspeed"] == "40 mph"
    assert len(corridor.ways[0].geometry) == 2
    assert len(corridor.nodes) == 1
    assert corridor.nodes[0].location == Coordinate(lat=51.505, lon=-0.105)


def test_parse_response_empty() -> None:
    corridor = parse_response({"elements": []})
    assert corridor.ways == []
    assert corridor.nodes == []


def test_chunk_polyline_short_route_single_chunk() -> None:
    chunks = chunk_polyline(_route().geometry, chunk_length_m=8000)
    assert len(chunks) == 1
    assert chunks[0] == _route().geometry


def test_chunk_polyline_splits_and_overlaps() -> None:
    # ~22 km straight line, points every ~1.1 km
    points = [Coordinate(lat=51.0 + i * 0.01, lon=0.0) for i in range(21)]
    chunks = chunk_polyline(points, chunk_length_m=8000)
    assert len(chunks) == 3
    # Boundary points are shared so the corridor has no gaps
    assert chunks[0][-1] == chunks[1][0]
    assert chunks[1][-1] == chunks[2][0]
    # Every original point appears in some chunk
    assert {(p.lat, p.lon) for c in chunks for p in c} == {(p.lat, p.lon) for p in points}
    # Each chunk is roughly the requested length
    for chunk in chunks[:-1]:
        length = sum(haversine_m(a, b) for a, b in zip(chunk, chunk[1:]))
        assert 8000 <= length < 10000
