from fastapi import APIRouter
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    build_id: str = ''
    version: str = ''


config = Settings()

router = APIRouter(
    prefix="/health",
    tags=["health"],
    dependencies=[],
    responses={404: {"description": "Not found"}},
)


@router.get("/")
async def get_health():
    return {"status": "OK", "buildId": config.build_id, "version": config.version}
