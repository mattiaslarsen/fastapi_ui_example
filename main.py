from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from services.actors import get_actors, get_actor_by_id, get_actors_by_country, get_oscar_winners, get_actor_stats
from models.actor import Actor
from typing import Dict, Any, List
from pydantic import BaseModel, Field

class APIResponse(BaseModel):
    """Standard API response för alla endpoints"""
    success: bool = Field(
        description="Indikerar om operationen lyckades",
        example=True
    )
    data: Any = Field(
        description="Response data (kan vara null vid fel)",
        default=None
    )
    message: str = Field(
        description="Beskrivande meddelande för användaren",
        example="Operation completed successfully",
        default=""
    )
    error: str = Field(
        description="Felmeddelande vid misslyckad operation",
        example="Resource not found",
        default=None
    )

class ActorListResponse(BaseModel):
    """Response för lista av skådespelare"""
    success: bool = Field(
        description="Indikerar om operationen lyckades",
        example=True
    )
    data: List[Actor] = Field(
        description="Lista av skådespelare",
        default=[]
    )
    total_count: int = Field(
        description="Totalt antal skådespelare i listan",
        example=5,
        ge=0
    )
    message: str = Field(
        description="Beskrivande meddelande",
        example="Hittade 5 skådespelare",
        default=""
    )

class StatsResponse(BaseModel):
    """Response för statistik-data"""
    success: bool = Field(
        description="Indikerar om operationen lyckades",
        example=True
    )
    data: Dict[str, Any] = Field(
        description="Statistik-data",
        example={
            "total_actors": 5,
            "total_oscars": 16,
            "unique_countries": 3,
            "countries": ["USA", "Storbritannien", "Sverige"],
            "average_oscars": 3.2
        },
        default={}
    )
    message: str = Field(
        description="Beskrivande meddelande",
        example="Statistik hämtad framgångsrikt",
        default=""
    )

app = FastAPI(
    title="Actor Showcase API",
    description="API för att visa skådespelare med deras detaljer - Pydantic som typmaster",
    version="1.0.0",
    openapi_tags=[
        {
            "name": "actors",
            "description": "Operations med skådespelare"
        },
        {
            "name": "stats", 
            "description": "Statistik-operationer"
        }
    ]
)

# CORS för frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/", tags=["root"])
def read_root():
    return {"message": "Actor Showcase API", "docs": "/docs"}

@app.get("/actors", response_model=ActorListResponse, tags=["actors"])
def read_actors():
    """Hämta alla skådespelare med strukturerad response"""
    try:
        actors = get_actors()
        return ActorListResponse(
            success=True,
            data=actors,
            total_count=len(actors),
            message=f"Hittade {len(actors)} skådespelare"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500, 
            detail=f"Kunde inte hämta skådespelare: {str(e)}"
        )

@app.get("/actors/{actor_id}", response_model=APIResponse, tags=["actors"])
def read_actor(actor_id: int):
    """Hämta specifik skådespelare med strukturerad response"""
    try:
        actor = get_actor_by_id(actor_id)
        if not actor:
            return APIResponse(
                success=False,
                error=f"Skådespelare med ID {actor_id} hittades inte"
            )
        return APIResponse(
            success=True,
            data=actor,
            message=f"Hittade skådespelare: {actor.name}"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Kunde inte hämta skådespelare: {str(e)}"
        )

@app.get("/actors/country/{country}", response_model=ActorListResponse, tags=["actors"])
def read_actors_by_country(country: str):
    """Hämta skådespelare från specifikt land"""
    try:
        actors = get_actors_by_country(country)
        return ActorListResponse(
            success=True,
            data=actors,
            total_count=len(actors),
            message=f"Hittade {len(actors)} skådespelare från {country}"
        )
    except Exception as e:
        raise HTTPException(
            status_code=400,
            detail=f"Kunde inte hämta skådespelare: {str(e)}"
        )

@app.get("/actors/oscar-winners", response_model=ActorListResponse, tags=["actors"])
def read_oscar_winners():
    """Hämta endast Oscar-vinnare"""
    try:
        actors = get_oscar_winners()
        return ActorListResponse(
            success=True,
            data=actors,
            total_count=len(actors),
            message=f"Hittade {len(actors)} Oscar-vinnare"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Kunde inte hämta Oscar-vinnare: {str(e)}"
        )

@app.get("/stats", response_model=StatsResponse, tags=["stats"])
def read_stats():
    """Hämta statistik för skådespelare"""
    try:
        stats = get_actor_stats()
        return StatsResponse(
            success=True,
            data=stats,
            message="Statistik hämtad framgångsrikt"
        )
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Kunde inte hämta statistik: {str(e)}"
        )

@app.get("/api/status", tags=["root"])
def get_api_status():
    """API status för frontend health check"""
    return {
        "status": "healthy",
        "message": "API är tillgängligt",
        "endpoints": {
            "actors": "/actors",
            "actor": "/actors/{id}",
            "country": "/actors/country/{country}",
            "oscar_winners": "/actors/oscar-winners",
            "stats": "/stats",
            "docs": "/docs"
        }
    } 