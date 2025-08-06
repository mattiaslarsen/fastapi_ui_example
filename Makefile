.PHONY: help api ui setup test docs

help:
	@echo "🎬 Actor Showcase – Vad vill du göra?"
	@echo ""
	@echo "🚀 Kör:"
	@echo "  make setup      – Installerar alla dependencies"
	@echo "  make api        – Startar FastAPI backend"
	@echo "  make ui         – Startar UI med Vite"
	@echo "  make test       – Kör alla tester"
	@echo "  make docs       – Öppnar API dokumentation"
	@echo ""

setup:
	@echo "📦 Installerar dependencies..."
	@uv sync

api:
	@echo "🚀 Startar FastAPI backend..."
	@uvicorn main:app --reload --host 0.0.0.0 --port 8000

ui:
	@echo "🎨 Startar UI (Vite)..."
	@cd ui && npm run dev

test:
	@echo "🧪 Kör tester..."
	@pytest

docs:
	@echo "📚 Öppnar API docs..."
	@echo "🌐 Swagger UI: http://localhost:8000/docs"
	@echo "📖 ReDoc: http://localhost:8000/redoc" 