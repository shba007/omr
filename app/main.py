
from fastapi import FastAPI

from .routers import health, scan

app = FastAPI()

app.include_router(health.router)
app.include_router(scan.router)
