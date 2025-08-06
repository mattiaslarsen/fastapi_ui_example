from models.actor import Actor
from typing import List, Optional

# Mock data - i verkligheten skulle detta komma från en databas
ACTORS_DATA = [
    Actor(id=1, name="Meryl Streep", birth_year=1949, country="USA", oscars=3),
    Actor(id=2, name="Daniel Day-Lewis", birth_year=1957, country="Storbritannien", oscars=3),
    Actor(id=3, name="Ingrid Bergman", birth_year=1915, country="Sverige", oscars=3),
    Actor(id=4, name="Jack Nicholson", birth_year=1937, country="USA", oscars=3),
    Actor(id=5, name="Katharine Hepburn", birth_year=1907, country="USA", oscars=4),
]

def get_actors() -> List[Actor]:
    """Hämta alla skådespelare med validering"""
    if not ACTORS_DATA:
        raise ValueError("Ingen skådespelardata tillgänglig")
    return ACTORS_DATA

def get_actor_by_id(actor_id: int) -> Optional[Actor]:
    """Hämta specifik skådespelare med validering"""
    if not isinstance(actor_id, int) or actor_id <= 0:
        raise ValueError("Ogiltigt actor ID")
    
    for actor in ACTORS_DATA:
        if actor.id == actor_id:
            return actor
    return None

def get_actors_by_country(country: str) -> List[Actor]:
    """Hämta skådespelare från specifikt land"""
    if not country:
        raise ValueError("Land måste anges")
    
    return [actor for actor in ACTORS_DATA if actor.country.lower() == country.lower()]

def get_oscar_winners() -> List[Actor]:
    """Hämta endast Oscar-vinnare"""
    return [actor for actor in ACTORS_DATA if actor.oscars > 0]

def get_actor_stats() -> dict:
    """Hämta statistik för skådespelare"""
    total_actors = len(ACTORS_DATA)
    total_oscars = sum(actor.oscars for actor in ACTORS_DATA)
    countries = list(set(actor.country for actor in ACTORS_DATA))
    
    return {
        "total_actors": total_actors,
        "total_oscars": total_oscars,
        "unique_countries": len(countries),
        "countries": countries,
        "average_oscars": total_oscars / total_actors if total_actors > 0 else 0
    } 