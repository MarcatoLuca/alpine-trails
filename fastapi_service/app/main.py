import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI
from app.database import create_db_and_tables, get_session

from app.map_marker import router as map_marker_router

import uvicorn


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("App is starting up...")

    create_db_and_tables()

    yield

    print("App is shutting down...")


app = FastAPI(
    title="Alpine Trails API",
    description="Alpine Trails - Dolomites",
    version="1.0.0",
)

app.include_router(map_marker_router.router, tags=["Map Marker"])


@app.get("/helloworld")
def hello_world():
    return {"message": "Hello, world!"}


if __name__ == "__main__":

    try:
        uvicorn.run("main:app", host="0.0.0.0", port=8000)

    except Exception as e:
        logging.exception(f"Exception occurred running main app: {e}")
