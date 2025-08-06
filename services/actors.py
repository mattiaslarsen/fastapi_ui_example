from typing import List
from models.actor import Actor

def get_actors() -> List[Actor]:
    """Return list of actors with their details"""
    return [
        Actor(id=1, name="Meryl Streep", birth_year=1949, country="USA", oscars=3),
        Actor(id=2, name="Denzel Washington", birth_year=1954, country="USA", oscars=2),
        Actor(id=3, name="Kate Winslet", birth_year=1975, country="UK", oscars=1),
        Actor(id=4, name="Leonardo DiCaprio", birth_year=1974, country="USA", oscars=1),
        Actor(id=5, name="Penélope Cruz", birth_year=1974, country="Spain", oscars=1),
        Actor(id=6, name="Bong Joon-ho", birth_year=1969, country="South Korea", oscars=4),
        Actor(id=7, name="Audrey Tautou", birth_year=1976, country="France", oscars=0),
        Actor(id=8, name="Chiwetel Ejiofor", birth_year=1977, country="UK", oscars=0),
        Actor(id=9, name="Zhang Ziyi", birth_year=1979, country="China", oscars=0),
        Actor(id=10, name="Mahershala Ali", birth_year=1974, country="USA", oscars=2)
    ]

def get_actor_by_id(actor_id: int) -> Actor | None:
    """Get specific actor by ID"""
    actors = get_actors()
    return next((actor for actor in actors if actor.id == actor_id), None) 