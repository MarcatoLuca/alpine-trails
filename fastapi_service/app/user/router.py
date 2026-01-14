from datetime import timedelta
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session, select
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import jwt, JWTError

from app.database import get_session
from app.security import ALGORITHM, REFRESH_TOKEN_SECRET_KEY, create_refresh_token, get_password_hash
from app.token.schemas import Token, RefreshTokenRequest

from ..user.models import User, UserCreate, UserPublic

from app.security import (
    verify_password,
    create_access_token,
    ACCESS_TOKEN_EXPIRE_MINUTES,
    SECRET_KEY,
)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="user/token")

router = APIRouter(
    prefix="/user",
    tags=["User"],
)

SessionDep = Annotated[Session, Depends(get_session)]

def authenticate_user(session: Session, email: str, password: str):
    """
    Verifica se un utente esiste e se la password è corretta.
    """
    user = session.exec(select(User).where(User.email == email)).first()
    if not user:
        return None  # L'utente non esiste
    if not verify_password(password, user.hashed_password):
        return None  # La password è sbagliata
    return user  # Autenticazione riuscita

async def get_current_user(
    token: Annotated[str, Depends(oauth2_scheme)], 
    session: SessionDep
) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        # Decodifica il token usando la SECRET_KEY degli access token
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
        
    user = session.exec(select(User).where(User.email == email)).first()
    if user is None:
        raise credentials_exception
    return user

@router.post("/token", response_model=Token)
def login_for_access_token(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()], session: SessionDep
):
    """
    Autentica l'utente e restituisce un token di accesso.
    """
    user = authenticate_user(
        session=session, email=form_data.username, password=form_data.password
    )

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # Crea il token
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )
    refresh_token = create_refresh_token(data={"sub": user.email})

    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer",
    }

@router.post("/token/refresh", response_model=Token)
def refresh_access_token(
    request: RefreshTokenRequest,
    session: SessionDep
):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate refresh token",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        # Valida il refresh token usando la sua chiave segreta
        payload = jwt.decode(request.refresh_token, REFRESH_TOKEN_SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    
    # Controlla che l'utente esista ancora
    user = session.exec(select(User).where(User.email == email)).first()
    if user is None:
        raise credentials_exception
        
    # Crea un NUOVO access token e un NUOVO refresh token (Token Rotation)
    new_access_token = create_access_token(data={"sub": user.email})
    new_refresh_token = create_refresh_token(data={"sub": user.email})

    return {
        "access_token": new_access_token,
        "refresh_token": new_refresh_token,
        "token_type": "bearer"
    }


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

@router.get("/me", response_model=UserPublic)
async def read_users_me(
    current_user: Annotated[User, Depends(get_current_user)]
):
    """
    Restituisce i dati dell'utente corrente se il token è valido.
    """
    return current_user
