from fastapi import Depends, HTTPException, APIRouter, Response
import logging
from sqlmodel import Session, select
from app.database import get_session
from typing import Annotated

from app.map_marker.outschema import MapMarkerOut
from app.map_marker.models import MapMarker

router = APIRouter()
SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/map_markers/all")
def get_all_map_markers(session: SessionDep) -> list[MapMarkerOut]:
    try:
        map_markers = session.exec(select(MapMarker)).all()

        if not map_markers:
            return []

        return [
            MapMarkerOut.create_from_sql_model_map_marker(map_marker)
            for map_marker in map_markers
        ]

    except HTTPException as http_exception:
        return Response(
            content=http_exception.detail, status_code=http_exception.status_code
        )

    except Exception as e:
        logging.exception(f"Exception occurred in getting map markers: {e}")
