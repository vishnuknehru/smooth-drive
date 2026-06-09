from pathlib import Path

from fastapi import FastAPI
from fastapi.responses import FileResponse

from smoothdrive.api.routes import router

STATIC_DIR = Path(__file__).parent / "static"

app = FastAPI(title="SmoothDrive", version="0.1.0")
app.include_router(router)


@app.get("/debug", include_in_schema=False)
async def debug_map() -> FileResponse:
    return FileResponse(STATIC_DIR / "debug.html")
