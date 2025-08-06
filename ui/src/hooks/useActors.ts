import { useState, useEffect } from 'react'
import { Actor } from '../types/actor'
import { API_ENDPOINTS, apiFetch } from '../lib/api'

export function useActors() {
  const [actors, setActors] = useState<Actor[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const fetchActors = async () => {
    try {
      setLoading(true)
      setError(null)
      const data = await apiFetch<Actor[]>(API_ENDPOINTS.actors)
      setActors(data)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Ett fel uppstod')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchActors()
  }, [])

  return { actors, loading, error, refetch: fetchActors }
} 