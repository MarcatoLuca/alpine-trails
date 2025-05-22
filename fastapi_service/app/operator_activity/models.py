from typing import Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

if TYPE_CHECKING:
    from ..operator.models import Operator # Corretto: punta al modulo operatore
    from ..activity.models import Activity # Corretto: punta al modulo attività

class OperatorActivity(SQLModel, table=True): # Nome classe corretto
    __tablename__ = "operator_activities" # Nome tabella DB

    operator_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="operators.id") # FK a Operator.__tablename__
    activity_id: Optional[int] = Field(default=None, primary_key=True, foreign_key="activities.id") # FK a Activity.__tablename__
