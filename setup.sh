#!/bin/bash

# 🎬 Actor Showcase Setup Script
# Kör detta i din WSL-miljö för att sätta upp hela projektet

set -e  # Stoppa vid fel

echo "🎬 Actor Showcase - Setup Script"
echo "================================"

# Kontrollera att vi är i rätt mapp
if [ ! -f "main.py" ]; then
    echo "❌ Fel: Kör detta skript från projektets rotmapp"
    exit 1
fi

echo "📦 Installerar Python dependencies..."
if command -v uv &> /dev/null; then
    uv sync
else
    echo "⚠️  uv inte installerat, använder pip..."
    pip install fastapi uvicorn pydantic
fi

echo "🎨 Skapar frontend med Vite..."
if command -v npm &> /dev/null; then
    # Kontrollera om ui-mappen redan finns
    if [ -d "ui" ]; then
        echo "⚠️  ui-mapp finns redan. Rensar och skapar om..."
        rm -rf ui
    fi
    
    # Skapa Vite React TypeScript projekt
    echo "🔧 Skapar Vite projekt..."
    npm create vite@latest ui -- --template react-ts --yes
    
    echo "📦 Installerar frontend dependencies..."
    cd ui
    npm install
    
    # Installera Tailwind CSS
    echo "🎨 Installerar Tailwind CSS..."
    npm install -D tailwindcss postcss autoprefixer
    
    # Skapa Tailwind och PostCSS config-filer direkt
    echo "⚙️  Konfigurerar Tailwind CSS..."
    cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF
    
    # Konfigurera PostCSS
    cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF
    
    # Lägg till Tailwind directives i CSS
    echo "📝 Lägger till Tailwind directives..."
    cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF
    
    # Kontrollera git-status
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo "✅ Git-repository hittat - shadcn/ui kommer att fungera korrekt"
    else
        echo "⚠️  Inget git-repository hittat. shadcn/ui kanske inte fungerar optimalt."
        echo "💡 Tips: Kör 'git init' innan setup om du vill ha full funktionalitet"
    fi
    
    # Lägg till shadcn/ui
    echo "🎨 Installerar shadcn/ui..."
    npx shadcn@latest init --yes
    npx shadcn@latest add card button badge --yes
    
    # Skapa en enkel Actor-komponent
    echo "🔧 Skapar Actor-komponenter..."
    mkdir -p src/components
    cd ..
else
    echo "❌ npm inte installerat. Installera Node.js först."
    exit 1
fi

echo "✅ Setup klar!"
echo ""
echo "🚀 Kör följande kommandon:"
echo "  make api    - Startar backend"
echo "  make ui     - Startar frontend (i annan terminal)"
echo "  make help   - Visa alla kommandon"
echo ""
echo "🌐 Backend: http://localhost:8000"
echo "🎨 Frontend: http://localhost:5173"
echo "📚 API Docs: http://localhost:8000/docs" 