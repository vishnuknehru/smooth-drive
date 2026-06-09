from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    ors_api_key: str = ""
    ors_base_url: str = "https://api.openrouteservice.org"
    overpass_base_url: str = "https://overpass-api.de/api/interpreter"

    # How far (metres) either side of the route to search for OSM features
    corridor_width_m: float = 25.0


@lru_cache
def get_settings() -> Settings:
    return Settings()
