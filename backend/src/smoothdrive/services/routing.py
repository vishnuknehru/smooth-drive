"""Routing providers behind a common interface (see ADR-003)."""

from typing import Protocol

import httpx

from smoothdrive.config import get_settings
from smoothdrive.domain.models import Coordinate, Route


class RoutingError(Exception):
    pass


class RoutingService(Protocol):
    async def get_route(self, start: Coordinate, end: Coordinate) -> Route: ...


def _route_from_geojson(coordinates: list[list[float]], distance: float) -> Route:
    geometry = [Coordinate(lat=lat, lon=lon) for lon, lat in coordinates]
    if len(geometry) < 2:
        raise RoutingError("Route geometry has fewer than 2 points")
    return Route(geometry=geometry, distance_meters=distance)


class ORSRoutingService:
    """OpenRouteService hosted API. Free tier: 2,000 directions requests/day."""

    def __init__(self, api_key: str | None = None, base_url: str | None = None) -> None:
        settings = get_settings()
        self._api_key = api_key if api_key is not None else settings.ors_api_key
        self._base_url = base_url or settings.ors_base_url

    async def get_route(self, start: Coordinate, end: Coordinate) -> Route:
        if not self._api_key:
            raise RoutingError("ORS_API_KEY is not set (see backend/.env.example)")
        url = f"{self._base_url}/v2/directions/driving-car/geojson"
        payload = {"coordinates": [[start.lon, start.lat], [end.lon, end.lat]]}
        async with httpx.AsyncClient(timeout=30) as client:
            response = await client.post(
                url, json=payload, headers={"Authorization": self._api_key}
            )
        if response.status_code != 200:
            raise RoutingError(f"ORS returned {response.status_code}: {response.text[:200]}")
        return self.parse_response(response.json())

    @staticmethod
    def parse_response(data: dict) -> Route:
        try:
            feature = data["features"][0]
            return _route_from_geojson(
                feature["geometry"]["coordinates"],
                feature["properties"]["summary"]["distance"],
            )
        except (KeyError, IndexError) as exc:
            raise RoutingError(f"Unexpected ORS response shape: {exc}") from exc


class OSRMRoutingService:
    """Public OSRM demo server. Keyless fallback for development and fixture capture."""

    def __init__(self, base_url: str = "https://router.project-osrm.org") -> None:
        self._base_url = base_url

    async def get_route(self, start: Coordinate, end: Coordinate) -> Route:
        url = (
            f"{self._base_url}/route/v1/driving/"
            f"{start.lon},{start.lat};{end.lon},{end.lat}"
        )
        params = {"overview": "full", "geometries": "geojson"}
        async with httpx.AsyncClient(timeout=30) as client:
            response = await client.get(url, params=params)
        if response.status_code != 200:
            raise RoutingError(f"OSRM returned {response.status_code}: {response.text[:200]}")
        return self.parse_response(response.json())

    @staticmethod
    def parse_response(data: dict) -> Route:
        if data.get("code") != "Ok" or not data.get("routes"):
            raise RoutingError(f"OSRM returned no route: {data.get('code')}")
        route = data["routes"][0]
        return _route_from_geojson(route["geometry"]["coordinates"], route["distance"])


def default_routing_service() -> RoutingService:
    """ORS when an API key is configured, otherwise the keyless OSRM demo."""
    if get_settings().ors_api_key:
        return ORSRoutingService()
    return OSRMRoutingService()
