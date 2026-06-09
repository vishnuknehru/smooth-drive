"""Geodesic helpers. Pure functions, no I/O."""

import math

from smoothdrive.domain.models import Coordinate

EARTH_RADIUS_M = 6_371_000.0


def haversine_m(a: Coordinate, b: Coordinate) -> float:
    """Great-circle distance between two coordinates in metres."""
    lat1, lon1 = math.radians(a.lat), math.radians(a.lon)
    lat2, lon2 = math.radians(b.lat), math.radians(b.lon)
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    h = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    return 2 * EARTH_RADIUS_M * math.asin(math.sqrt(h))


def bearing_deg(a: Coordinate, b: Coordinate) -> float:
    """Initial bearing from a to b in degrees [0, 360)."""
    lat1, lat2 = math.radians(a.lat), math.radians(b.lat)
    dlon = math.radians(b.lon - a.lon)
    x = math.sin(dlon) * math.cos(lat2)
    y = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(dlon)
    return math.degrees(math.atan2(x, y)) % 360


def bearing_difference_deg(a: float, b: float) -> float:
    """Smallest angle between two bearings, folded to [0, 90].

    Folding treats opposite directions as equal, so a way digitized against
    the direction of travel still matches.
    """
    diff = abs(a - b) % 180
    return min(diff, 180 - diff)


def cumulative_distances_m(points: list[Coordinate]) -> list[float]:
    """Running distance along a polyline; same length as points, starts at 0."""
    distances = [0.0]
    for previous, current in zip(points, points[1:]):
        distances.append(distances[-1] + haversine_m(previous, current))
    return distances


def _local_xy(point: Coordinate, origin: Coordinate) -> tuple[float, float]:
    """Equirectangular projection to metres relative to origin. Accurate at street scale."""
    x = math.radians(point.lon - origin.lon) * math.cos(math.radians(origin.lat)) * EARTH_RADIUS_M
    y = math.radians(point.lat - origin.lat) * EARTH_RADIUS_M
    return x, y


def point_to_segment_m(point: Coordinate, seg_start: Coordinate, seg_end: Coordinate) -> tuple[float, float]:
    """Perpendicular distance from point to segment, and the fraction t in [0, 1]
    of the closest position along the segment."""
    px, py = _local_xy(point, seg_start)
    ex, ey = _local_xy(seg_end, seg_start)
    seg_len_sq = ex * ex + ey * ey
    if seg_len_sq == 0:
        return math.hypot(px, py), 0.0
    t = max(0.0, min(1.0, (px * ex + py * ey) / seg_len_sq))
    return math.hypot(px - t * ex, py - t * ey), t


def project_onto_polyline(
    point: Coordinate, polyline: list[Coordinate], cumdist: list[float]
) -> tuple[float, float]:
    """Closest position of point on polyline.

    Returns (distance along the polyline in metres, offset from it in metres).
    cumdist must be cumulative_distances_m(polyline).
    """
    best_offset = math.inf
    best_along = 0.0
    for i in range(len(polyline) - 1):
        offset, t = point_to_segment_m(point, polyline[i], polyline[i + 1])
        if offset < best_offset:
            best_offset = offset
            best_along = cumdist[i] + t * (cumdist[i + 1] - cumdist[i])
    return best_along, best_offset


def downsample(points: list[Coordinate], min_spacing_m: float) -> list[Coordinate]:
    """Thin a polyline so consecutive points are at least min_spacing_m apart.

    First and last points are always kept.
    """
    if len(points) <= 2:
        return list(points)
    kept = [points[0]]
    for point in points[1:-1]:
        if haversine_m(kept[-1], point) >= min_spacing_m:
            kept.append(point)
    kept.append(points[-1])
    return kept
