.PHONY: help api ui sync test docs clean fresh reset venv activate frontend

help:
	@echo "🎬 Actor Showcase – Vad vill du göra?"
	@echo ""
	@echo "🚀 Kör:"
	@echo "  make sync      – Installerar backend dependencies (uv sync)"
	@echo "  make activate  – Aktiverar backend venv (source .venv/bin/activate)"
	@echo "  make api       – Startar FastAPI backend (automatisk venv)"
	@echo "  make ui        – Startar UI med Vite"
	@echo "  make test      – Kör alla tester"
	@echo "  make docs      – Öppnar API dokumentation"
	@echo ""
	@echo "🎨 Frontend setup:"
	@echo "  make frontend  – Installerar React + Tailwind + shadcn/ui"
	@echo ""
	@echo "🔄 Reset (säker start om):"
	@echo "  make reset     – Säkert start om (deaktiverar venv + fresh)"
	@echo "  make clean     – Rensar allt (venv, ui, cache)"
	@echo "  make fresh     – Startar om från början (backend + frontend)"
	@echo ""
	@echo "💡 Tips: Använd 'make reset' för säker start om!"

sync:
	@echo "📦 Installerar backend dependencies..."
	@uv sync

activate:
	@echo "🐍 Aktivera backend venv:"
	@echo "source .venv/bin/activate"
	@echo ""
	@echo "💡 Lämna venv: deactivate"
	@echo "💡 Eller använd: make api (automatisk venv)"

frontend:
	@echo "🎨 Installerar frontend dependencies..."
	@./setup.sh

api:
	@echo "🚀 Startar FastAPI backend..."
	@uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000

ui:
	@echo "🎨 Startar UI (Vite)..."
	@cd ui && npm run dev

test:
	@echo "🧪 Kör tester..."
	@uv run pytest

docs:
	@echo "📚 Öppnar API docs..."
	@echo "🌐 Swagger UI: http://localhost:8000/docs"
	@echo "📖 ReDoc: http://localhost:8000/redoc"

venv:
	@echo "🐍 Venv instruktioner:"
	@echo "💡 Aktivera: source .venv/bin/activate"
	@echo "💡 Lämna: deactivate"
	@echo "💡 Eller använd: make api (automatisk venv)"

clean:
	@echo "🧹 Rensar allt..."
	@rm -rf .venv
	@rm -rf ui
	@rm -rf .uv
	@rm -rf __pycache__
	@rm -rf .pytest_cache
	@rm -rf .mypy_cache
	@echo "✅ Rensning klar!"

fresh: clean
	@echo "🔄 Startar om från början..."
	@echo "📦 Steg 1: Backend dependencies..."
	@$(MAKE) sync
	@echo ""
	@echo "🎨 Steg 2: Frontend dependencies..."
	@$(MAKE) frontend
	@echo ""
	@echo "✅ Setup klar!"
	@echo ""
	@echo "🐍 Nästa steg:"
	@echo "  make api    - Startar backend (automatisk venv)"
	@echo "  make ui     - Startar frontend (i annan terminal)"
	@echo "  make activate - Visar venv-kommando"
	@echo ""
	@echo "💡 Tips: Du behöver INTE aktivera venv manuellt för make api!"

reset:
	@echo "🔄 Säkert start om..."
	@echo "📋 Steg 1: Kontrollerar om du är i venv..."
	@if [ -n "$$VIRTUAL_ENV" ]; then \
		echo "⚠️  Du är i venv: $$VIRTUAL_ENV"; \
		echo "💡 Kör: deactivate"; \
		echo "💡 Sedan: make fresh"; \
		echo ""; \
		echo "🔧 Eller kör detta kommando för att automatiskt lämna venv:"; \
		echo "   deactivate && make fresh"; \
	else \
		echo "✅ Inte i venv - kör fresh direkt..."; \
		$(MAKE) fresh; \
	fi 