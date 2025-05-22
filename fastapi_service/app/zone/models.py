from typing import List, Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

from ..operator_zone.models import OperatorZone # Per i type hints
if TYPE_CHECKING:
    from ..operator.models import Operator

class ZoneBase(SQLModel):
    name: str = Field(index=True, unique=True)

class Zone(ZoneBase, table=True):
    __tablename__ = "zones"

    id: Optional[int] = Field(default=None, primary_key=True) # Optional per auto-increment

    operators: List["Operator"] = Relationship(
        back_populates="zones",
        link_model=OperatorZone # STRINGA: Nome della CLASSE OperatorZone
    )

class ZonePublic(ZoneBase):
    id: int