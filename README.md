# 🎬 Actor Showcase

En modern FastAPI + React-applikation som visar skådespelare med deras detaljer.

## 🚀 Snabbstart

Kör setup-skriptet i din WSL-miljö:

```bash
chmod +x setup.sh
./setup.sh
```

## 📁 Projektstruktur

- **Backend**: FastAPI med actors service och Pydantic models
- **Frontend**: React + TypeScript med shadcn/ui komponenter
- **Orchestration**: Makefile med outcome-driven kommandon

## 🎯 Vad gör vad

- `main.py` - FastAPI-applikation med CORS och endpoints
- `services/actors.py` - Business logic för skådespelardata
- `models/actor.py` - Pydantic-modell för datastruktur
- `ui/` - React frontend med modern UI-komponenter

## 🔧 Kommandon

Kör `make help` för att se alla tillgängliga kommandon.

## 📚 Dokumentation

- **Systemkarta**: `maps.yaml` - AI-läsbar översikt över moduler
- **API Docs**: http://localhost:8000/docs (efter `make api`)
- **Frontend**: http://localhost:5173 (efter `make ui`)

## 🧩 Modulära delar

Projektet är uppbyggt för att vara modulärt och AI-promptbart. Varje del har tydligt syfte och beroenden som beskrivs i `maps.yaml`. 