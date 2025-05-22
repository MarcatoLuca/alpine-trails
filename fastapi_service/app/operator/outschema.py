from pydantic import BaseModel, Field

from app.operator.models import OperatorPublicWithAttributes
from app.activity.models import ActivityPublic
from app.zone.models import ZonePublic

class OperatorOut(BaseModel):
    name: str = Field(max_length=255)
    description: str | None = Field(default=None, nullable=True)
    phone: str | None = Field(default=None, nullable=True)
    email: str | None = Field(default=None, nullable=True)
    website: str | None = Field(default=None, nullable=True)
    activities: list[ActivityPublic]
    zones: list[ZonePublic]

    @classmethod
    def create_operator_with_activities_and_zones(cls, operator: OperatorPublicWithAttributes, activities: list[ActivityPublic], zones: list[ZonePublic]):
        return cls(name=operator.name, description=operator.description, phone=operator.phone, email=operator.email, website=operator.website, activities=activities, zones=zones)