# 🎬 Actor Showcase

AI-driven FastAPI + React applikation som följer rörlighetsprinciperna. Backend hanterar all logik, frontend visar bara.

## 🚀 Snabbstart

```bash
make help          # Se alla kommandon
make api-types     # Backend + automatisk type-generering
make ui-types      # Frontend + type-synkronisering
```

## 🎯 Viktiga workflows

### Backend-utveckling
```bash
make api-types     # Startar backend + genererar types från Pydantic
make validate-api  # Testar backend-logik
```

### Frontend-utveckling  
```bash
make ui-types      # Genererar types + startar UI
make validate-ui   # Testar frontend pure presentation
```

### Fullstack validering
```bash
make validate-full # Validerar alla rörlighetsprinciper
```

## 🏗️ Arkitektur

**Backend-logik förstärkning** - All business logic i API  
**Frontend pure presentation** - UI visar bara data  
**Pydantic som typmaster** - Automatisk TypeScript-generering  
**Loose coupling** - API fungerar oberoende av UI  

## 📁 Struktur

- `main.py` - FastAPI med strukturerade responses
- `models/actor.py` - Pydantic som typmaster
- `services/actors.py` - Business logic
- `ui/src/` - Pure presentation components
- `maps.yaml` - AI-läsbart systemregister

## 🔗 Länkar

- [Makefile](Makefile) - Alla kommandon och workflows
- [maps.yaml](maps.yaml) - AI-läsbar systemkarta
- [API docs](http://localhost:8000/docs) - Swagger UI (kör `make api` först)

## 💡 Tips

- Använd `make api-types` för backend-utveckling
- Använd `make ui-types` för frontend-utveckling  
- Kör `make validate-full` för att testa rörlighetsprinciperna
- Se `make help` för alla kommandon 