from typing import List, Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

# Usiamo TYPE_CHECKING per evitare import circolari
if TYPE_CHECKING:
    from ..activity.models import Activity, ActivityPublic
    from ..zone.models import Zone, ZonePublic
    from ..user.models import User
    from ..operator_activity.models import OperatorActivity
    from ..operator_zone.models import OperatorZone
    from ..user_favorite_operators.models import UserFavoriteOperator

# --- Modello Base ---
class OperatorBase(SQLModel):
    name: str = Field(max_length=100)
    description: Optional[str] = Field(default=None)
    phone: Optional[str] = Field(default=None, max_length=50)
    email: Optional[str] = Field(default=None, max_length=255)
    website: Optional[str] = Field(default=None, max_length=255)

# --- Modello della Tabella del Database ---
class Operator(OperatorBase, table=True):
    __tablename__ = "operators"

    id: Optional[int] = Field(default=None, primary_key=True)

    activities: List["Activity"] = Relationship(
        back_populates="operators", link_model=OperatorActivity
    )
    zones: List["Zone"] = Relationship(
        back_populates="operators", link_model=OperatorZone
    )
    favorited_by_users: List["User"] = Relationship(
        back_populates="favorite_operators", link_model=UserFavoriteOperator
    )

# --- Schemi per l'API (Input/Output) ---
class OperatorCreate(OperatorBase):
    pass 

class OperatorPublic(OperatorBase):
    id: int 

class OperatorPublicWithDetails(OperatorPublic):
    activities: List["ActivityPublic"] = []
    zones: List["ZonePublic"] = []