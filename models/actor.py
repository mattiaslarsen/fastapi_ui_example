from pydantic import BaseModel

class Actor(BaseModel):
    id: int
    name: str
    birth_year: int
    country: str
    oscars: int 