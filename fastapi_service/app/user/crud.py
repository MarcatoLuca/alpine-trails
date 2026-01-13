from fastapi import Depends, APIRouter
from typing import Annotated
import logging
from sqlmodel import Session, select
from app.database import get_session, engine

from ..user.models import UserCreate, User

router = APIRouter()
SessionDep = Annotated[Session, Depends(get_session)]

def create_user(user: UserCreate):
    try:
        with Session(engine) as session:
            db_user = User.model_validate(user)
            session.add(db_user)
            session.commit()
            session.refresh(db_user)
            return db_user
    
    except Exception as e:
        logging.exception(f'Exception occurred in CREATE User: {e}')

