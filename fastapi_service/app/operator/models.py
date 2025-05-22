from typing import List, Optional, TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship

from ..operator_activity.models import OperatorActivity  # Per i type hints
from ..operator_zone.models import OperatorZone  # Per i type hints
from ..activity.models import Activity, ActivityPublic
from ..zone.models import Zone, ZonePublic


class OperatorBase(SQLModel):
    name: str = Field(max_length=100)
    description: str | None = Field(nullable=True)
    phone: str | None = Field(max_length=50, nullable=True)
    email: str | None = Field(max_length=255, nullable=True)
    website: str | None = Field(max_length=255, nullable=True)


class Operator(OperatorBase, table=True):
    __tablename__ = "operators"  # Nome tabella DB

    id: Optional[int] = Field(
        default=None, primary_key=True
    )  # Optional per auto-increment

    activities: List["Activity"] = Relationship(
        back_populates="operators",
        link_model=OperatorActivity,  # STRINGA: Nome della CLASSE OperatorActivity
    )

    zones: List["Zone"] = Relationship(
        back_populates="operators",
        link_model=OperatorZone,  # STRINGA: Nome della CLASSE OperatorZone
    )


class OperatorPublic(OperatorBase):
    id: int


class OperatorPublicWithAttributes(OperatorPublic):
    activities: ActivityPublic
    zones: ZonePublic
