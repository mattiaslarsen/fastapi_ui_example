import { Card, CardContent, CardHeader, CardTitle } from "./ui/card"
import { Badge } from "./ui/badge"
// Importera genererade types från OpenAPI
import type { components } from "../types/api"

type Actor = components['schemas']['Actor']

interface ActorCardProps {
  actor: Actor
}

// Pure presentation component - ingen logik
export function ActorCard({ actor }: ActorCardProps) {
  return (
    <Card className="w-full hover:shadow-lg hover:shadow-primary/20 transition-all duration-300 group">
      <CardHeader className="pb-4">
        <CardTitle className="flex items-center justify-between">
          <span className="text-xl font-bold group-hover:text-primary transition-colors">
            {actor.name}
          </span>
          {actor.oscars > 0 && (
            <Badge className="bg-gradient-to-r from-yellow-500 to-orange-500 text-white border-0 px-3 py-1">
              🏆 {actor.oscars} Oscar{actor.oscars > 1 ? 's' : ''}
            </Badge>
          )}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          <div className="flex items-center gap-3">
            <span className="text-sm text-muted-foreground">Land:</span>
            <Badge variant="outline">
              {actor.country}
            </Badge>
          </div>
          <div className="flex items-center gap-3">
            <span className="text-sm text-muted-foreground">Född:</span>
            <span className="text-sm font-medium bg-muted px-3 py-1 rounded">
              {actor.birth_year}
            </span>
          </div>
          
          {/* Oscar-statistik */}
          <div className="pt-3 border-t border-border">
            <div className="flex items-center justify-between">
              <span className="text-xs text-muted-foreground">Oscar-snitt:</span>
              <span className="text-sm font-semibold text-primary">
                {actor.oscars > 0 ? '🏆' : '—'} {actor.oscars}
              </span>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  )
} 