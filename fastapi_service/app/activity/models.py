from typing import List, Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

from ..operator_activity.models import OperatorActivity # Per i type hints
if TYPE_CHECKING:
    from ..operator.models import Operator

class ActivityBase(SQLModel):
    name: str = Field(index=True)

class Activity(ActivityBase, table=True):
    __tablename__ = "activities" # Nome tabella DB

    id: Optional[int] = Field(default=None, primary_key=True) # Optional per auto-increment

    operators: List["Operator"] = Relationship(
        back_populates="activities",
        link_model=OperatorActivity # STRINGA: Nome della CLASSE OperatorActivity
    )

class ActivityPublic(ActivityBase):
    id: int