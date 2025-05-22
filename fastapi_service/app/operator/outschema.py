from pydantic import BaseModel, Field

from app.operator.models import OperatorPublicWithAttributes
from app.activity.models import ActivityPublic
from app.zone.models import ZonePublic

class OperatorOut(BaseModel):
    name: str = Field(max_length=255)
    description: str
    activities: list[ActivityPublic]
    zones: list[ZonePublic]

    @classmethod
    def create_operator_with_activities_and_zones(cls, operator: OperatorPublicWithAttributes, activities: list[ActivityPublic], zones: list[ZonePublic]):
        return cls(name=operator.name, description=operator.description, activities=activities, zones=zones)