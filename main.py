from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from services.actors import get_actors, get_actor_by_id
from models.actor import Actor

app = FastAPI(
    title="Actor Showcase API",
    description="API för att visa skådespelare med deras detaljer",
    version="1.0.0"
)

# CORS för frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "Actor Showcase API", "docs": "/docs"}

@app.get("/actors", response_model=list[Actor])
def read_actors():
    """Hämta alla skådespelare"""
    return get_actors()

@app.get("/actors/{actor_id}", response_model=Actor)
def read_actor(actor_id: int):
    """Hämta specifik skådespelare"""
    actor = get_actor_by_id(actor_id)
    if not actor:
        raise HTTPException(status_code=404, detail="Actor not found")
    return actor 