from pydantic import BaseModel, Field
from app.map_marker.models import MapMarkerPublic


class MapMarkerOut(BaseModel):
    name: str
    type: str | None = Field(default=None, max_length=100, nullable=True)
    latitude: float
    longitude: float
    description: str | None = Field(default=None, nullable=True)

    @classmethod
    def create_from_sql_model_map_marker(cls, sql_model: MapMarkerPublic):
        return cls(
            name=sql_model.name,
            type=sql_model.type,
            latitude=sql_model.latitude,
            longitude=sql_model.longitude,
            description=sql_model.description,
        )
