from pydantic import BaseModel

from smoothdrive.domain.models import Coordinate


class OSMNode(BaseModel):
    id: int
    tags: dict[str, str] = {}
    location: Coordinate


class OSMWay(BaseModel):
    id: int
    tags: dict[str, str] = {}
    geometry: list[Coordinate]


class CorridorData(BaseModel):
    """Everything Overpass returned for the corridor around a route."""

    ways: list[OSMWay]
    nodes: list[OSMNode]
