# ADR-003: OpenRouteService for routing, Overpass for metadata, both behind interfaces

**Status:** Accepted — 2026-06-09

## Context
We need (a) a route between two points and (b) road metadata along that route. No single free API provides both with speed-limit detail. Self-hosting OSRM was considered but adds setup cost before feasibility is proven.

## Decision
- **Routing:** OpenRouteService hosted API (free tier, 2,000 directions/day) returning GeoJSON.
- **Metadata:** Overpass API corridor query (`around` filter on the route polyline) for `maxspeed` ways, `highway=traffic_signals` nodes and roundabouts.
- Both clients sit behind small service interfaces (`RoutingService`, `OverpassService`) so providers can be replaced (TomTom, Mapbox, self-hosted OSRM/Overpass) without touching the extraction engine.

## Consequences
- Zero cost and zero infrastructure for Phase 1.
- Rate limits require caching: one Overpass query per analyzed route, responses saved as test fixtures.
- Public Overpass instances can be slow or briefly unavailable; acceptable for a prototype, revisit before launch.
