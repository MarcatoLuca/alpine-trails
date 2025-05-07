import logging

from fastapi import FastAPI

import uvicorn


app = FastAPI(
    title="Alpine Trails API",
    description="Alpine Trails - Dolomites",
    version="1.0.0",
)


@app.get("/helloworld")
def hello_world():
    return {"message": "Hello, world!"}


if __name__ == "__main__":

    try:
        uvicorn.run("main:app", host="0.0.0.0", port=8000)

    except Exception as e:
        logging.exception(f"Exception occurred running main app: {e}")
