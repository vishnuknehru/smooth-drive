# ADR-002: FastAPI + Python 3.12 for the backend

**Status:** Accepted — 2026-06-09

## Context
Phase 1 is a feasibility prototype: fetch routes, query OSM, run geometry calculations, expose JSON. Iteration speed matters more than raw performance.

## Decision
Python 3.12 with FastAPI, managed by `uv`. Async `httpx` for outbound calls (ORS, Overpass). Pydantic models double as the API contract and the domain model.

## Consequences
- Fast iteration, automatic OpenAPI docs at `/docs`, typed request/response validation for free.
- Geometry maths in pure Python is fine at route scale (thousands of points, not millions).
- If the product later needs a low-latency on-device engine, this logic ports to the mobile app; the backend remains the source of truth during validation.
