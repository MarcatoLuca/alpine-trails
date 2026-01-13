from typing import List, Annotated, Optional
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session, select
from sqlalchemy.orm import selectinload

from app.database import get_session
from . import models
from app.activity.models import Activity
from app.zone.models import Zone

router = APIRouter(
    prefix="/operators",
    tags=["Operators"],
)

SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/", response_model=List[models.OperatorPublicWithDetails])
def get_all_operators( # Nome funzione al plurale
    session: SessionDep,
    name: Optional[str] = Query(default=None),
    zone_name: Optional[str] = Query(default=None),
    activity_names: Optional[List[str]] = Query(default=None),
    skip: int = Query(default=0, ge=0),
    limit: int = Query(default=100, ge=1, le=200),
):
    """
    Recupera una lista di operatori con filtri e paginazione.
    Carica in modo efficiente le attività e le zone associate.
    """
    statement = (
        select(models.Operator)
        .options(
            selectinload(models.Operator.activities), 
            selectinload(models.Operator.zones)
        )
    )

    if name:
        statement = statement.where(models.Operator.name.ilike(f"%{name}%"))
    if zone_name:
        statement = statement.where(models.Operator.zones.any(Zone.name == zone_name))
    if activity_names:
        for activity_name in activity_names:
            statement = statement.where(models.Operator.activities.any(Activity.name == activity_name))

    statement = statement.order_by(models.Operator.id).offset(skip).limit(limit)

    operators = session.exec(statement).all()
    
    return operators


@router.get("/{operator_id}", response_model=models.OperatorPublicWithDetails)
def get_operator_by_id(
    operator_id: int,
    session: SessionDep,
):
    """
    Recupera un singolo operatore tramite ID, con le sue attività e zone.
    """
    statement = (
        select(models.Operator)
        .where(models.Operator.id == operator_id)
        .options(
            selectinload(models.Operator.activities), 
            selectinload(models.Operator.zones)
        )
    )
    operator = session.exec(statement).first()

    if not operator:
        raise HTTPException(
            status_code=404, detail=f"Operator with id {operator_id} not found"
        )
    
    return operator