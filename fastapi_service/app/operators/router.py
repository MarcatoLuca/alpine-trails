from typing import List, Annotated, Optional
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session, select
from sqlalchemy.orm import selectinload

from app.database import get_session
from app.user.router import get_current_user
from . import models
from app.activity.models import Activity
from app.zone.models import Zone
from app.user.models import User

router = APIRouter(
    prefix="/operators",
    tags=["Operators"],
)

SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/", response_model=List[models.OperatorPublicWithDetails])
def get_all_operators(  # Nome funzione al plurale
    session: SessionDep,
    current_user: Annotated[User, Depends(get_current_user)],
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
    statement = select(models.Operator).options(
        selectinload(models.Operator.activities), selectinload(models.Operator.zones)
    )

    if name:
        statement = statement.where(models.Operator.name.ilike(f"%{name}%"))
    if zone_name:
        statement = statement.where(models.Operator.zones.any(Zone.name == zone_name))
    if activity_names:
        for activity_name in activity_names:
            statement = statement.where(
                models.Operator.activities.any(Activity.name == activity_name)
            )

    statement = statement.order_by(models.Operator.id).offset(skip).limit(limit)

    operators = session.exec(statement).all()
    operators_public = []

    for operator in operators:
        operator_data = models.OperatorPublicWithDetails.model_validate(operator)
        operator_data.is_favorite = any(
            fav.id == operator.id for fav in current_user.favorite_operators
        )
        operators_public.append(operator_data)

    return operators_public


@router.get("/{operator_id}", response_model=models.OperatorPublicWithDetails)
def get_operator_by_id(
    operator_id: int,
    session: SessionDep,
    current_user: Annotated[User, Depends(get_current_user)],
):
    """
    Recupera un singolo operatore tramite ID, con le sue attività e zone.
    """
    statement = (
        select(models.Operator)
        .where(models.Operator.id == operator_id)
        .options(
            selectinload(models.Operator.activities),
            selectinload(models.Operator.zones),
        )
    )
    operator = session.exec(statement).first()

    if not operator:
        raise HTTPException(
            status_code=404, detail=f"Operator with id {operator_id} not found"
        )

    operators_public = models.OperatorPublicWithDetails.model_validate(operator)

    operators_public.is_favorite = any(
        fav.id == operator_id for fav in current_user.favorite_operators
    )

    return operators_public


@router.get("/favorites/", response_model=List[int])
def get_favorite_operators(
    session: SessionDep,
    current_user: Annotated["User", Depends(get_current_user)],
):
    """
    Recupera la lista degli operatori preferiti dell'utente corrente.
    """
    session.refresh(current_user)  # Assicurati che le relazioni siano caricate
    return [op.id for op in current_user.favorite_operators]


@router.post(
    "/favorites/{operator_id}", response_model=models.OperatorPublicWithDetails
)
def add_favorite_operator(
    operator_id: int,
    session: SessionDep,
    current_user: Annotated["User", Depends(get_current_user)],
):
    """
    Aggiunge un operatore ai preferiti dell'utente corrente.
    """
    operator = session.get(models.Operator, operator_id)
    if not operator:
        raise HTTPException(status_code=404, detail="Operator not found")

    if operator not in current_user.favorite_operators:
        current_user.favorite_operators.append(operator)
        session.add(current_user)
        session.commit()
        session.refresh(operator, ["activities", "zones"])
    else:
        session.refresh(operator, ["activities", "zones"])

    operator_data = models.OperatorPublicWithDetails.model_validate(operator)
    operator_data.is_favorite = True
    return operator_data


@router.delete(
    "/favorites/{operator_id}", response_model=models.OperatorPublicWithDetails
)
def remove_favorite_operator(
    operator_id: int,
    session: SessionDep,
    current_user: Annotated["User", Depends(get_current_user)],
):
    """
    Rimuove un operatore dai preferiti dell'utente corrente.
    """
    operator = session.get(models.Operator, operator_id)
    if not operator:
        raise HTTPException(status_code=404, detail="Operator not found")

    if operator in current_user.favorite_operators:
        current_user.favorite_operators.remove(operator)
        session.add(current_user)
        session.commit()
        session.refresh(operator, ["activities", "zones"])
    else:
        session.refresh(operator, ["activities", "zones"])

    operator_data = models.OperatorPublicWithDetails.model_validate(operator)
    operator_data.is_favorite = False
    return operator_data
