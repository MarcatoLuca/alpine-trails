from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session, select

from app.database import get_session
from app.operators import models
from app.security import get_password_hash

from ..user.models import User, UserCreate, UserPublic

router = APIRouter(
    prefix="/user",
    tags=["User"],
)


@router.post("/", response_model=UserPublic, status_code=status.HTTP_201_CREATED)
def create_user(*, session: Session = Depends(get_session), user_in: UserCreate):
    """
    Crea un nuovo utente.
    """
    existing_user = session.exec(
        select(User).where(User.email == user_in.email)
    ).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered.",
        )

    user_data = user_in.model_dump(exclude={"password"})

    hashed_password = get_password_hash(user_in.password)

    db_user = User(**user_data, hashed_password=hashed_password)

    session.add(db_user)
    session.commit()
    session.refresh(db_user)

    return db_user
