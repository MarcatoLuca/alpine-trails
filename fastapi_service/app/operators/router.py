from fastapi import Depends, HTTPException, APIRouter, Response
import logging
from fastapi.responses import JSONResponse
from sqlmodel import Session, select
from app.database import get_session
from typing import Annotated, List
from sqlalchemy.orm import selectinload
from fastapi import Query

from app.operators.models import Operator
from app.activity.models import Activity
from app.zone.models import Zone

router = APIRouter(
    prefix="/operator",
    tags=["Operator"],
)
SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/", response_model=List[OperatorOut])
def get_all_operator(
    session: SessionDep,
    name: str | None = Query(default=None),
    zone_name: str | None = Query(default=None),
    activity_names: List[str] | None = Query(
        default=None,
    ),
    skip: int = Query(
        default=0,
        ge=0,
    ),
    limit: int = Query(
        default=100,
        ge=1,
        le=200,
    ),
) -> list[OperatorOut]:

    try:
        statement = select(Operator).options(
            selectinload(Operator.activities), selectinload(Operator.zones)
        )

        # Applica filtri
        if name:
            statement = statement.where(Operator.name.ilike(f"%{name}%"))
        if zone_name:
            statement = statement.where(Operator.zones.any(Zone.name == zone_name))
        if activity_names:
            statement = statement.where(
                Operator.activities.any(Activity.name.in_(activity_names))
            )

        statement = statement.order_by(Operator.id)

        statement = statement.offset(skip).limit(limit)

        operators = session.exec(statement).all()
        return operators

    except Exception as e:
        logging.exception(f"Exception occurred in getting all operators: {e}")
        raise HTTPException(status_code=500, detail="Internal Server Error")


@router.get("/{operator_id}", response_model=OperatorOut)
def get_operator_by_id(
    operator_id: int,
    session: SessionDep,
) -> OperatorOut:
    try:
        statement = (
            select(Operator)
            .where(Operator.id == operator_id)
            .options(selectinload(Operator.activities), selectinload(Operator.zones))
        )

        operator = session.exec(statement).first()

        if not operator:
            raise HTTPException(
                status_code=404, detail=f"Operator with id {operator_id} not found"
            )

        return operator

    except Exception as e:
        logging.exception(
            f"Exception occurred in getting operator with id {operator_id}: {e}"
        )
        raise HTTPException(status_code=500, detail="Internal Server Error")
