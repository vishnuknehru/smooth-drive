"""Replay a recorded GPX drive against the SmoothDrive API.

Usage (from backend/, with the server running):
    uv run python ../tools/gpx_replay.py path/to/drive.gpx [--api http://localhost:8000] [--step 5]

Analyzes the route from the track's first to last point, then steps through
the recorded positions printing what the driver would have been told.
"""

import argparse
import sys

import gpxpy
import httpx

from smoothdrive.domain.models import Coordinate
from smoothdrive.services.smoothness import build_report

MI = 1609.34


def label(event: dict) -> str:
    if event["type"] == "speed_limit":
        value = event["value_mph"]
        return f"speed limit -> {value} mph" if value else "speed limit -> unknown"
    return event["type"].replace("_", " ")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("gpx_file")
    parser.add_argument("--api", default="http://localhost:8000")
    parser.add_argument("--step", type=int, default=5, help="use every Nth track point")
    args = parser.parse_args()

    with open(args.gpx_file) as handle:
        gpx = gpxpy.parse(handle)
    points = [p for track in gpx.tracks for seg in track.segments for p in seg.points]
    if len(points) < 2:
        sys.exit("GPX file contains no track points")
    print(f"Loaded {len(points)} track points")

    client = httpx.Client(base_url=args.api, timeout=300)
    response = client.post(
        "/api/route/analyze",
        json={
            "start": {"lat": points[0].latitude, "lon": points[0].longitude},
            "end": {"lat": points[-1].latitude, "lon": points[-1].longitude},
        },
    )
    response.raise_for_status()
    analysis = response.json()
    print(
        f"Route {analysis['route_id']}: {analysis['distance_meters'] / MI:.1f} mi, "
        f"{len(analysis['events'])} events\n"
    )

    stepped = points[:: args.step]
    last_advice_key: tuple | None = None
    previous = None
    late_reactions = 0
    for point in stepped:
        speed_mph = None
        if previous is not None and point.time and previous.time:
            dt = (point.time - previous.time).total_seconds()
            if dt > 0:
                speed_mph = previous.distance_2d(point) / dt / 0.44704
        previous = point

        request = {"route_id": analysis["route_id"], "lat": point.latitude, "lon": point.longitude}
        if speed_mph is not None:
            request["speed_mph"] = round(speed_mph, 1)
        response = client.post("/api/position/upcoming", json=request)
        response.raise_for_status()
        upcoming = response.json()
        position_mi = upcoming["position_on_route_meters"] / MI
        timestamp = point.time.strftime("%H:%M:%S") if point.time else "        "
        speed_str = f"{speed_mph:3.0f} mph" if speed_mph is not None else "  ? mph"

        if upcoming["off_route"]:
            print(f"{timestamp}  {position_mi:6.2f} mi  {speed_str}  OFF ROUTE")
            continue

        advice = upcoming.get("advice")
        if not advice:
            continue
        event = advice.get("event") or {}
        advice_key = (advice["action"], advice.get("target_mph"), event.get("type"))
        # Print when the advice changes, like a driver would hear it
        if advice_key != last_advice_key:
            if advice["action"] != "maintain":
                print(
                    f"{timestamp}  {position_mi:6.2f} mi  {speed_str}  "
                    f"{advice['action'].upper().replace('_', ' ')}: {advice['message']}"
                )
            if advice["action"] in ("brake_gently", "brake"):
                late_reactions += 1
            last_advice_key = advice_key

    samples = [
        (p.time, Coordinate(lat=p.latitude, lon=p.longitude)) for p in points if p.time
    ]
    if len(samples) < 3:
        print("\nNo timestamps in GPX — skipping smoothness report")
        return
    report = build_report(samples, late_reactions=late_reactions)
    print("\n--- Drive summary ---")
    print(f"Distance:  {report.distance_miles:.1f} mi   Duration: {report.duration_minutes:.0f} min")
    print(f"Harsh decelerations: {len(report.harsh_events)}")
    for event in report.harsh_events:
        print(
            f"  {event.time.strftime('%H:%M:%S')}  {event.from_mph:.0f}→{event.to_mph:.0f} mph "
            f"({event.peak_decel_ms2:.1f} m/s²) at {event.location.lat:.4f},{event.location.lon:.4f}"
        )
    print(f"Late reactions (advisor had escalated to braking): {report.late_reactions}")
    print(f"Smoothness score: {report.score}/100")


if __name__ == "__main__":
    main()
