from sqlmodel import Field, SQLModel


class MapMarkerBase(SQLModel):
    name: str | None = Field(default=None, max_length=150, nullable=False)
    type: str | None = Field(default=None, max_length=100, nullable=False)
    latitude: float | None = Field(default=None, nullable=False)
    longitude: float | None = Field(default=None, nullable=False)
    description: str | None = Field(default=None, max_length=500, nullable=True)


class MapMarker(MapMarkerBase, table=True):
    id: int | None = Field(default=None, primary_key=True)


class MapMarkerPublic(MapMarkerBase):
    """
    When a map marker is required in responses read from the clients,
    the id must be specified. Hence, it will be contained in this model.
    """
    id: int
