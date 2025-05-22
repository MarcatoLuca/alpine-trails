from typing import Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

if TYPE_CHECKING:
    from ..operator.models import Operator # Corretto
    from ..zone.models import Zone       # Corretto

class OperatorZone(SQLModel, table=True): # Nome classe corretto
    __tablename__ = "operator_zones" # Nome tabella DB

    operator_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="operators.id") # FK a Operator.__tablename__
    zone_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="zones.id")         # FK a Zone.__tablename__
