from datetime import datetime
from typing import List, Optional, TYPE_CHECKING 
from sqlmodel import Field, SQLModel, Relationship

from ..user_favorite_operators.models import UserFavoriteOperator  # Per i type hints

if TYPE_CHECKING:
    from ..operators.models import Operator, OperatorPublic  # Per i type hints

class UserBase(SQLModel):
    email: str = Field(max_length=255)
    first_name: str = Field(max_length=100)
    last_name: str = Field(max_length=100)


class User(UserBase, table=True):
    __tablename__ = "users"

    id: int = Field(default=None, primary_key=True)
    hashed_password: str
    created_at: datetime = Field(
        default_factory=datetime.now, nullable=False
    )  # Modo migliore di gestire la data

    favorite_operators: List["Operator"] = Relationship(
        back_populates="favorited_by_users",
        link_model=UserFavoriteOperator,  # STRINGA: Nome della CLASSE OperatorActivity
    )


class UserCreate(UserBase):
    password: str = Field(max_length=8)


class UserPublic(UserBase):
    """
    When a user is required in responses read from the clients,
    the id must be specified. Hence, it will be contained in this model.
    """

    id: int


class UserPublicWithAttributes(UserPublic):
    favorite_operators: List["OperatorPublic"] = []
