"""Orchestrates routing → corridor fetch → event extraction, with a route cache
so a moving position can be evaluated without re-fetching anything."""

import uuid
from dataclasses import dataclass

from smoothdrive.config import get_settings
from smoothdrive.domain.models import (
    Coordinate,
    Route,
    RouteAnalysis,
    UpcomingEvent,
    UpcomingResponse,
)
from smoothdrive.services.advisor import advise
from smoothdrive.services.events import extract_events
from smoothdrive.services.geometry import cumulative_distances_m, project_onto_polyline
from smoothdrive.services.overpass import OverpassService
from smoothdrive.services.routing import RoutingService

# Position further from the route than this counts as off-route
OFF_ROUTE_THRESHOLD_M = 50.0


@dataclass
class _CachedRoute:
    analysis: RouteAnalysis
    cumdist: list[float]


class RouteAnalyzer:
    def __init__(self, routing: RoutingService, overpass: OverpassService) -> None:
        self._routing = routing
        self._overpass = overpass
        self._cache: dict[str, _CachedRoute] = {}

    async def analyze(self, start: Coordinate, end: Coordinate) -> RouteAnalysis:
        route = await self._routing.get_route(start, end)
        corridor = await self._overpass.fetch_corridor(route)
        events = extract_events(route, corridor)
        analysis = RouteAnalysis(
            route_id=uuid.uuid4().hex[:12],
            distance_meters=route.distance_meters,
            geometry=route.geometry,
            events=events,
        )
        self._cache[analysis.route_id] = _CachedRoute(
            analysis=analysis, cumdist=cumulative_distances_m(route.geometry)
        )
        return analysis

    def upcoming(
        self, route_id: str, position: Coordinate, speed_mph: float | None = None
    ) -> UpcomingResponse | None:
        cached = self._cache.get(route_id)
        if cached is None:
            return None
        along, offset = project_onto_polyline(
            position, cached.analysis.geometry, cached.cumdist
        )
        events = [
            UpcomingEvent(
                type=event.type,
                distance_ahead_meters=event.distance_meters - along,
                location=event.location,
                value_mph=event.value_mph,
            )
            for event in cached.analysis.events
            if event.distance_meters > along
        ]
        advice = None
        if speed_mph is not None:
            advice = advise(speed_mph, events, get_settings())
        return UpcomingResponse(
            route_id=route_id,
            position_on_route_meters=along,
            off_route=offset > OFF_ROUTE_THRESHOLD_M,
            events=events,
            advice=advice,
        )
