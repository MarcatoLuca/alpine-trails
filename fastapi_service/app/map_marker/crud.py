from fastapi import Depends, APIRouter
from typing import Annotated
import logging
from sqlmodel import Session, select
from app.database import get_session
from app.map_marker.models import MapMarkerPublic, MapMarker

router = APIRouter()
SessionDep = Annotated[Session, Depends(get_session)]

def read_map_markers(session: SessionDep) -> list[MapMarkerPublic]:
    try:
        map_markers = session.exec(select(MapMarker)).all()
        if not map_markers: return []
        return map_markers
    
    except Exception as e:
        logging.exception(f'Exception occurred in GET map markers: {e}')