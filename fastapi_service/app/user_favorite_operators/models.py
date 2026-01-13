from typing import Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel

if TYPE_CHECKING:
    from ..operators.models import Operator # Corretto: punta al modulo operatore
    from ..user.models import User # Corretto: punta al modulo utente

class UserFavoriteOperator(SQLModel, table=True): # Nome classe corretto
    __tablename__ = "user_favorite_operators" # Nome tabella DB

    user_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="users.id") # FK a User.__tablename__
    operator_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="operators.id") # FK a Operator.__tablename__