from fastapi import Depends, APIRouter
from typing import Annotated
import logging
from sqlmodel import Session, select
from app.database import get_session

from app.operator.models import Operator, OperatorPublicWithAttributes

router = APIRouter()
SessionDep = Annotated[Session, Depends(get_session)]

def read_operators(session: SessionDep) -> list[OperatorPublicWithAttributes]:
    try:
        operator = session.exec(select(Operator)).all()
        if not operator: return []
        return operator
    
    except Exception as e:
        logging.exception(f'Exception occurred in GET multiple Operator(s): {e}')