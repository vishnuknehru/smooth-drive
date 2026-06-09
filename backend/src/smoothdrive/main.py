from fastapi import FastAPI

from smoothdrive.api.routes import router

app = FastAPI(title="SmoothDrive", version="0.1.0")
app.include_router(router)
