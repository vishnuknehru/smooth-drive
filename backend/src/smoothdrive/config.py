from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    ors_api_key: str = ""
    ors_base_url: str = "https://api.openrouteservice.org"
    overpass_base_url: str = "https://overpass-api.de/api/interpreter"

    # How far (metres) either side of the route to search for OSM features
    corridor_width_m: float = 25.0

    # Driver intelligence: single "comfort" profile, tune after real drives.
    liftoff_decel_ms2: float = 1.0  # easing off the accelerator / engine braking
    gentle_brake_decel_ms2: float = 2.0
    alert_lead_s: float = 20.0  # how far ahead of the lift-off point to advise
    signal_lead_s: float = 15.0  # shorter horizon: the light may well be green
    roundabout_entry_mph: int = 12
    signal_approach_mph: int = 10


@lru_cache
def get_settings() -> Settings:
    return Settings()
