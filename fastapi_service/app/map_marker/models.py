from typing import Optional
from sqlmodel import Field, SQLModel

# --- Modello Base ---
class MapMarkerBase(SQLModel):
    name: str = Field(max_length=255)
    type: str = Field(max_length=100)
    latitude: float
    longitude: float
    description: Optional[str] = Field(default=None) 

# --- Modello della Tabella del Database ---
class MapMarker(MapMarkerBase, table=True):
    __tablename__ = "mapmarker" 
    
    id: Optional[int] = Field(default=None, primary_key=True)

# --- Schemi per l'API (Input/Output) ---
class MapMarkerCreate(MapMarkerBase):
    pass

class MapMarkerPublic(MapMarkerBase):
    id: int