# ADR-001: Use OpenStreetMap as the road-data source

**Status:** Accepted — 2026-06-09

## Context
SmoothDrive needs speed limits, traffic-signal locations and roundabouts along a route. Commercial providers (TomTom, HERE, Mapbox) expose some of this but charge per request and restrict caching. Phase 1 must validate feasibility at zero cost.

## Decision
Use OpenStreetMap data, accessed via the public Overpass API, as the sole road-metadata source for Phase 1.

## Consequences
- £0 cost, no contract, generous fair-use limits.
- Data quality varies by area — UK coverage of `maxspeed` and `highway=traffic_signals` is good in urban areas but has gaps. Phase 1 validation (GPX replay of real drives) explicitly measures this.
- When a way has no `maxspeed` tag we report `unknown` rather than guessing.
- If accuracy proves insufficient, the services are abstracted so a commercial provider can be swapped in (see ADR-003).
