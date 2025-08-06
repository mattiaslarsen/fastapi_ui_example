import { useState, useEffect } from 'react'
import { ActorCard } from './components/ActorCard'
import { Button } from './components/ui/button'
import './App.css'

interface Actor {
  id: number
  name: string
  birth_year: number
  country: string
  oscars: number
}

function App() {
  const [actors, setActors] = useState<Actor[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    fetchActors()
  }, [])

  const fetchActors = async () => {
    try {
      setLoading(true)
      setError(null)
      const response = await fetch('http://localhost:8000/actors')
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      const data = await response.json()
      setActors(data)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Ett fel uppstod')
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Hämtar skådespelare...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center max-w-md">
          <h2 className="text-xl font-semibold text-red-600 mb-4">Kunde inte hämta data</h2>
          <p className="text-gray-600 mb-4">{error}</p>
          <p className="text-sm text-gray-500 mb-4">
            Kontrollera att backend körs med: <code className="bg-gray-200 px-2 py-1 rounded">make api</code>
          </p>
          <Button onClick={fetchActors} className="bg-blue-600 hover:bg-blue-700">
            Försök igen
          </Button>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="container mx-auto px-4 py-8">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">🎬 Actor Showcase</h1>
          <p className="text-gray-600">Skådespelare från FastAPI backend</p>
        </div>
        
        {actors.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-gray-500">Inga skådespelare hittades</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {actors.map((actor) => (
              <ActorCard key={actor.id} actor={actor} />
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

export default App
