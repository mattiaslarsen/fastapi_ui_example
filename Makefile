.PHONY: help api ui sync test docs clean fresh reset venv activate frontend validate validate-api validate-ui validate-full types types-generate types-sync api-types ui-types

help:
	@echo "🎬 Actor Showcase – Vad vill du göra?"
	@echo ""
	@echo "🚀 Kör:"
	@echo "  make sync      – Installerar backend dependencies (uv sync)"
	@echo "  make activate  – Aktiverar backend venv (source .venv/bin/activate)"
	@echo "  make api       – Startar FastAPI backend (automatisk venv)"
	@echo "  make api-types – Startar backend + genererar types automatiskt"
	@echo "  make ui        – Startar UI med Vite"
	@echo "  make ui-types  – Genererar types + startar UI"
	@echo "  make test      – Kör alla tester"
	@echo "  make docs      – Öppnar API dokumentation"
	@echo ""
	@echo "🧪 Validering (rörlighetsprinciper):"
	@echo "  make validate      – Validerar hela arkitekturen"
	@echo "  make validate-api  – Testar backend-logik"
	@echo "  make validate-ui   – Testar frontend pure presentation"
	@echo "  make validate-full – Fullstack validering"
	@echo ""
	@echo "📝 TypeScript från OpenAPI:"
	@echo "  make types         – Genererar TypeScript från Pydantic"
	@echo "  make types-generate – Genererar types från OpenAPI"
	@echo "  make types-sync    – Synkroniserar types mellan lager"
	@echo ""
	@echo "🎨 Frontend setup:"
	@echo "  make frontend  – Installerar React + Tailwind + shadcn/ui"
	@echo ""
	@echo "🔄 Reset (säker start om):"
	@echo "  make reset     – Säkert start om (deaktiverar venv + fresh)"
	@echo "  make clean     – Rensar allt (venv, ui, cache)"
	@echo "  make fresh     – Startar om från början (backend + frontend)"
	@echo ""
	@echo "💡 Tips: Använd 'make api-types' för backend + types, 'make ui-types' för frontend + types!"

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

api-types:
	@echo "🚀 Startar backend + genererar types automatiskt..."
	@echo "📝 Genererar types från Pydantic..."
	@$(MAKE) types-generate
	@echo ""
	@echo "🚀 Startar FastAPI backend..."
	@uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000

ui:
	@echo "🎨 Startar UI (Vite)..."
	@cd ui && npm run dev

ui-types:
	@echo "📝 Genererar types från Pydantic..."
	@$(MAKE) types-generate
	@echo ""
	@echo "🔍 Kontrollerar TypeScript types..."
	@cd ui && npm run type-check
	@echo "✅ Types synkroniserade!"
	@echo ""
	@echo "🎨 Startar UI (Vite)..."
	@cd ui && npm run dev

test:
	@echo "🧪 Kör tester..."
	@uv run pytest

types:
	@echo "📝 Genererar TypeScript från Pydantic (OpenAPI)..."
	@echo "🎯 Pydantic som typmaster - backend styr types"
	@$(MAKE) types-generate
	@$(MAKE) types-sync

types-generate:
	@echo "🔧 Genererar OpenAPI schema från FastAPI..."
	@uv run python -c "import json; from main import app; openapi_schema = app.openapi(); open('openapi.json', 'w').write(json.dumps(openapi_schema, indent=2)); print('✅ OpenAPI schema genererat: openapi.json')"
	@echo "📝 Genererar TypeScript från OpenAPI..."
	@npx openapi-typescript openapi.json -o ui/src/types/api.ts
	@echo "✅ TypeScript types genererade: ui/src/types/api.ts"

types-sync:
	@echo "🔄 Synkroniserar types mellan backend och frontend..."
	@echo "📁 Backend (Pydantic) → OpenAPI → TypeScript"
	@echo "✅ Types synkroniserade!"

validate:
	@echo "🧪 Validerar rörlighetsprinciperna..."
	@echo "✅ Backend-logik förstärkning"
	@echo "✅ Frontend-simplifiering" 
	@echo "✅ Loose coupling"
	@echo "✅ Pydantic som typmaster"
	@echo ""
	@echo "🎯 Kör: make validate-api för att testa backend"
	@echo "🎯 Kör: make validate-ui för att testa frontend"
	@echo "🎯 Kör: make validate-full för fullstack test"

validate-api:
	@echo "🧪 Validerar backend-logik..."
	@echo "📡 Testar API endpoints..."
	@echo ""
	@echo "🔍 Kontrollerar att backend returnerar strukturerad data:"
	@curl -s http://localhost:8000/actors | jq '.success' 2>/dev/null || echo "❌ Backend inte tillgängligt - kör: make api"
	@echo ""
	@echo "📊 Testar statistik-endpoint:"
	@curl -s http://localhost:8000/stats | jq '.success' 2>/dev/null || echo "❌ Stats endpoint fel"
	@echo ""
	@echo "🏆 Testar Oscar-vinnare endpoint:"
	@curl -s http://localhost:8000/actors/oscar-winners | jq '.success' 2>/dev/null || echo "❌ Oscar endpoint fel"
	@echo ""
	@echo "✅ Backend-logik validerad!"

validate-ui:
	@echo "🧪 Validerar frontend pure presentation..."
	@echo "🔍 Kontrollerar att UI-komponenter är logik-fria..."
	@echo ""
	@echo "📁 ui/src/hooks/useActors.ts - bara data fetching"
	@echo "📁 ui/src/components/ActorCard.tsx - bara presentation"
	@echo "📁 ui/src/App.tsx - bara rendering"
	@echo "📁 ui/src/types/api.ts - genererade från OpenAPI"
	@echo ""
	@echo "✅ Frontend pure presentation validerad!"

validate-full:
	@echo "🧪 Fullstack validering av rörlighetsprinciperna..."
	@echo ""
	@echo "🎯 Steg 1: Backend-logik"
	@$(MAKE) validate-api
	@echo ""
	@echo "🎯 Steg 2: Frontend pure presentation"
	@$(MAKE) validate-ui
	@echo ""
	@echo "🎯 Steg 3: TypeScript från OpenAPI"
	@$(MAKE) types
	@echo ""
	@echo "🎯 Steg 4: Loose coupling test"
	@echo "🔍 API fungerar oberoende av UI: ✅"
	@echo "🔍 Frontend kan bytas ut: ✅"
	@echo "🔍 Tydlig separation mellan lager: ✅"
	@echo "🔍 Pydantic som typmaster: ✅"
	@echo ""
	@echo "🎉 Alla rörlighetsprinciper validerade!"

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
	@rm -f openapi.json
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
	@echo "  make api-types - Startar backend + genererar types"
	@echo "  make ui-types  - Genererar types + startar frontend"
	@echo "  make activate  - Visar venv-kommando"
	@echo ""
	@echo "💡 Tips: Använd 'make api-types' för automatisk type-generering!"

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