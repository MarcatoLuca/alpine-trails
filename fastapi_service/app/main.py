import logging
from typing import Annotated
from contextlib import asynccontextmanager
from fastapi import FastAPI, Depends

from sqlmodel import Session

from app.database import create_db_and_tables, get_session

from app.map_marker import router as map_marker_router
from app.operator import router as operator_router


import uvicorn

SessionDep = Annotated[Session, Depends(get_session)]


@asynccontextmanager
async def lifespan(app: FastAPI):
    logging.info("App is starting up...")
    try:
        create_db_and_tables()
        logging.info("Database tables checked/created.")
    except Exception as e:
        logging.error(f"Error creating database tables: {e}", exc_info=True)
    yield
    logging.info("App is shutting down...")


app = FastAPI(
    title="Alpine Trails API",
    description="Alpine Trails - Dolomites",
    version="1.0.0",
    lifespan=lifespan,
)

app.include_router(map_marker_router.router, tags=["Map Marker"])
app.include_router(operator_router.router, tags=["Operators"])


@app.get("/helloworld")
def hello_world():
    return {"message": "Hello, world!"}


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)  # Configura il logging di base
    try:
        # Passa l'app string come "app.main:app" se esegui uvicorn dalla directory sopra 'app'
        # o "main:app" se esegui dalla directory 'app' (dove si trova main.py)
        uvicorn.run(
            "app.main:app", host="0.0.0.0", port=8000, reload=True
        )  # Aggiunto reload per sviluppo
    except Exception as e:
        logging.exception(f"Exception occurred running Uvicorn: {e}")
