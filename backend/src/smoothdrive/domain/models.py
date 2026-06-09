from enum import StrEnum

from pydantic import BaseModel, Field


class Coordinate(BaseModel):
    lat: float = Field(ge=-90, le=90)
    lon: float = Field(ge=-180, le=180)


class EventType(StrEnum):
    SPEED_LIMIT = "speed_limit"
    TRAFFIC_SIGNAL = "traffic_signal"
    ROUNDABOUT = "roundabout"


class Event(BaseModel):
    type: EventType
    distance_meters: float = Field(ge=0, description="Distance along the route from its start")
    location: Coordinate
    value_mph: int | None = Field(
        default=None, description="New speed limit in mph; None unless type is speed_limit"
    )


class Route(BaseModel):
    """A route as a sequence of coordinates with total length."""

    geometry: list[Coordinate]
    distance_meters: float


class RouteAnalysis(BaseModel):
    route_id: str
    distance_meters: float
    geometry: list[Coordinate]
    events: list[Event]


class AnalyzeRequest(BaseModel):
    start: Coordinate
    end: Coordinate


class UpcomingRequest(BaseModel):
    route_id: str
    lat: float = Field(ge=-90, le=90)
    lon: float = Field(ge=-180, le=180)


class UpcomingEvent(BaseModel):
    type: EventType
    distance_ahead_meters: float
    location: Coordinate
    value_mph: int | None = None


class UpcomingResponse(BaseModel):
    route_id: str
    position_on_route_meters: float
    off_route: bool = Field(description="True if the position is far from the route")
    events: list[UpcomingEvent]
