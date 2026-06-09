from functools import lru_cache

from fastapi import APIRouter, HTTPException

from smoothdrive.domain.models import (
    AnalyzeRequest,
    Coordinate,
    RouteAnalysis,
    UpcomingRequest,
    UpcomingResponse,
)
from smoothdrive.services.analyzer import RouteAnalyzer
from smoothdrive.services.overpass import OverpassError, OverpassService
from smoothdrive.services.routing import RoutingError, default_routing_service

router = APIRouter()


@lru_cache
def get_analyzer() -> RouteAnalyzer:
    return RouteAnalyzer(routing=default_routing_service(), overpass=OverpassService())


@router.get("/health")
async def health() -> dict[str, str]:
    return {"status": "ok"}


@router.post("/api/route/analyze")
async def analyze_route(request: AnalyzeRequest) -> RouteAnalysis:
    try:
        return await get_analyzer().analyze(request.start, request.end)
    except (RoutingError, OverpassError) as exc:
        raise HTTPException(status_code=502, detail=str(exc)) from exc


@router.post("/api/position/upcoming")
async def upcoming_events(request: UpcomingRequest) -> UpcomingResponse:
    response = get_analyzer().upcoming(
        request.route_id,
        Coordinate(lat=request.lat, lon=request.lon),
        speed_mph=request.speed_mph,
    )
    if response is None:
        raise HTTPException(status_code=404, detail=f"Unknown route_id {request.route_id!r}")
    return response
