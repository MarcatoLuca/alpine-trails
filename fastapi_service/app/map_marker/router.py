from typing import List, Annotated
from fastapi import APIRouter, Depends
from sqlmodel import Session, select

from app.database import get_session
# Importiamo i modelli dal nostro file pulito
from . import models

router = APIRouter(
    prefix="/map_markers",
    tags=["Map Markers"], # Plurale è più comune per i tag
)

SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/", response_model=List[models.MapMarkerPublic])
def get_all_map_markers(session: SessionDep):
    """
    Recupera tutti i punti di interesse sulla mappa.
    """
    map_markers = session.exec(select(models.MapMarker)).all()
    
    return map_markers