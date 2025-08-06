import { Card, CardContent, CardHeader, CardTitle } from "./ui/card"
import { Badge } from "./ui/badge"

interface Actor {
  id: number
  name: string
  birth_year: number
  country: string
  oscars: number
}

interface ActorCardProps {
  actor: Actor
}

export function ActorCard({ actor }: ActorCardProps) {
  return (
    <Card className="w-full max-w-sm">
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <span className="text-lg font-semibold">{actor.name}</span>
          {actor.oscars > 0 && (
            <Badge variant="secondary" className="bg-yellow-100 text-yellow-800">
              🏆 {actor.oscars} Oscar{actor.oscars > 1 ? 's' : ''}
            </Badge>
          )}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-2">
          <div className="flex items-center gap-2">
            <span className="text-sm text-gray-500">Land:</span>
            <Badge variant="outline">{actor.country}</Badge>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-sm text-gray-500">Född:</span>
            <span className="text-sm font-medium">{actor.birth_year}</span>
          </div>
        </div>
      </CardContent>
    </Card>
  )
} 