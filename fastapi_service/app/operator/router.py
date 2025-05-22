from fastapi import Depends, HTTPException, APIRouter, Response
import logging
from fastapi.responses import JSONResponse
from sqlmodel import Session, select
from app.database import get_session
from typing import Annotated, List
from sqlalchemy.orm import selectinload

from app.operator.outschema import OperatorOut
from app.operator.models import Operator

router = APIRouter()
SessionDep = Annotated[Session, Depends(get_session)]


@router.get("/operator/all", response_model=List[OperatorOut])
def get_all_operator(session: SessionDep) -> list[OperatorOut]:

    try:
        statement = select(Operator).options(
            selectinload(Operator.activities), selectinload(Operator.zones)
        )
        operators = session.exec(statement).all()

        if not operators:
            return []

        operators_out = []
        for op in operators:
            operators_out.append(
                OperatorOut.create_operator_with_activities_and_zones(
                    operator=op,
                    activities=op.activities,  # Relazione caricata
                    zones=op.zones,  # Relazione caricata
                )
            )
        return operators_out

    except HTTPException as http_exception:
        return Response(
            content=http_exception.detail, status_code=http_exception.status_code
        )

    except Exception as e:
        logging.exception(f"Exception occurred in getting operators: {e}")


@router.get("/operator/${operator_id}", response_model=OperatorOut)
def get_operator_by_id(operator_id: int, session: SessionDep) -> OperatorOut:
    try:
        statement = (
            select(Operator)
            .where(Operator.id == operator_id)
            .options(selectinload(Operator.activities), selectinload(Operator.zones))
        )

        operator = session.exec(statement).first()

        if not operator:
            return JSONResponse(content={})

        return operator

    except HTTPException as http_exception:
        return Response(
            content=http_exception.detail, status_code=http_exception.status_code
        )

    except Exception as e:
        logging.exception(
            f"Exception occurred in getting operator with id ${operator_id}: {e}"
        )
