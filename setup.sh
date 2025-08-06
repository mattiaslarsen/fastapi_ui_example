#!/bin/bash

# 🎨 Frontend Setup Script
# Kör detta för att sätta upp React + Tailwind + shadcn/ui

set -e  # Stoppa vid fel

echo "🎨 Frontend Setup Script"
echo "========================"

# Kontrollera att vi är i rätt mapp
if [ ! -f "main.py" ]; then
    echo "❌ Fel: Kör detta skript från projektets rotmapp"
    exit 1
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
    
    # Installera Tailwind CSS med rätt PostCSS plugin
    echo "🎨 Installerar Tailwind CSS..."
    npm install -D tailwindcss @tailwindcss/postcss postcss autoprefixer
    
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
    
    # Konfigurera PostCSS med rätt plugin för Tailwind v4
    cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    '@tailwindcss/postcss': {},
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
    
    # Konfigurera TypeScript import alias för shadcn/ui
    echo "⚙️  Konfigurerar TypeScript import alias..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,

    /* Path mapping */
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF
    
    # Konfigurera Vite för import alias
    echo "⚙️  Konfigurerar Vite import alias..."
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
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

echo "✅ Frontend setup klar!"
echo ""
echo "🎨 Frontend: http://localhost:5173"
echo "💡 Kör 'make setup' för backend dependencies"
echo "💡 Kör 'make fresh' för båda tillsammans" 