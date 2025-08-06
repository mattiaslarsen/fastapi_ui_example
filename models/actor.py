from pydantic import BaseModel, Field
from typing import Optional

class Actor(BaseModel):
    """Skådespelare med detaljerad information"""
    
    id: int = Field(
        description="Unikt ID för skådespelaren",
        example=1,
        ge=1
    )
    
    name: str = Field(
        description="Skådespelarens fullständiga namn",
        example="Meryl Streep",
        min_length=1,
        max_length=100
    )
    
    birth_year: int = Field(
        description="Födelseår för skådespelaren",
        example=1949,
        ge=1800,
        le=2024
    )
    
    country: str = Field(
        description="Land där skådespelaren är född eller bor",
        example="USA",
        min_length=2,
        max_length=50
    )
    
    oscars: int = Field(
        description="Antal Oscar-priser som skådespelaren har vunnit",
        example=3,
        ge=0,
        le=10
    )
    
    class Config:
        """Pydantic konfiguration för OpenAPI-generering"""
        schema_extra = {
            "example": {
                "id": 1,
                "name": "Meryl Streep",
                "birth_year": 1949,
                "country": "USA",
                "oscars": 3
            }
        }
        # Aktivera OpenAPI-generering
        json_schema_extra = {
            "examples": [
                {
                    "id": 1,
                    "name": "Meryl Streep",
                    "birth_year": 1949,
                    "country": "USA",
                    "oscars": 3
                },
                {
                    "id": 2,
                    "name": "Daniel Day-Lewis",
                    "birth_year": 1957,
                    "country": "Storbritannien",
                    "oscars": 3
                }
            ]
        } 