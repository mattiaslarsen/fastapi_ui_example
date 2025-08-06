import { ActorCard } from './components/ActorCard'
import { Button } from './components/ui/button'
import { useActors } from './hooks/useActors'
import './App.css'
import { useState } from 'react'

function App() {
  const { actors, loading, error, refetch } = useActors()
  const [isDark, setIsDark] = useState(false)

  const toggleDarkMode = () => {
    setIsDark(!isDark)
    document.documentElement.classList.toggle('dark')
  }

  // Pure presentation - ingen logik
  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-4 border-primary border-t-transparent mx-auto mb-6"></div>
          <p className="text-muted-foreground text-lg">Hämtar skådespelare...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center max-w-md bg-card p-8 rounded-2xl border border-destructive">
          <h2 className="text-2xl font-bold text-destructive mb-4">Kunde inte hämta data</h2>
          <p className="text-muted-foreground mb-6">{error}</p>
          <p className="text-sm text-muted-foreground mb-6">
            Kontrollera att backend körs med: <code className="bg-muted px-3 py-1 rounded text-primary">make api</code>
          </p>
          <Button onClick={refetch} variant="default">
            Försök igen
          </Button>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* Hero Section */}
      <div className="bg-gradient-to-r from-primary to-primary/80 p-16">
        <div className="container mx-auto px-4">
          <div className="text-center">
            <div className="flex justify-end mb-4">
              <Button 
                onClick={toggleDarkMode} 
                variant="outline" 
                size="sm"
                className="bg-primary-foreground/10 border-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/20"
              >
                {isDark ? '☀️' : '🌙'} {isDark ? 'Ljus' : 'Mörk'} läge
              </Button>
            </div>
            <h1 className="text-5xl font-bold text-primary-foreground mb-4">
              🎬 Actor Showcase - HOT RELOAD TEST
            </h1>
            <p className="text-xl text-primary-foreground/80 mb-8">
              Skådespelare från FastAPI backend - Ny design, samma data!
            </p>
            <div className="flex justify-center space-x-4">
              <div className="bg-primary-foreground/10 border border-primary-foreground/20 rounded-lg px-6 py-3">
                <span className="text-primary-foreground font-semibold">{actors.length} skådespelare</span>
              </div>
              <div className="bg-primary-foreground/10 border border-primary-foreground/20 rounded-lg px-6 py-3">
                <span className="text-primary-foreground font-semibold">
                  {actors.reduce((sum, actor) => sum + actor.oscars, 0)} Oscar-priser
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Content Section */}
      <div className="container mx-auto px-4 py-12">
        {actors.length === 0 ? (
          <div className="text-center py-16">
            <div className="bg-card border border-border rounded-xl p-8">
              <p className="text-muted-foreground text-lg">Inga skådespelare hittades</p>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {actors.map((actor) => (
              <ActorCard key={actor.id} actor={actor} />
            ))}
          </div>
        )}
      </div>

      {/* Footer */}
      <div className="border-t border-border mt-16">
        <div className="container mx-auto px-4 py-8">
          <div className="text-center">
            <p className="text-muted-foreground">
              🏗️ Rörlighetsprinciper följda: Backend-logik oberoende av UI-design
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

export default App
