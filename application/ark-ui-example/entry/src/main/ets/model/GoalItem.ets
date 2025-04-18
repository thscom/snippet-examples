

export class GoalItem {
  id: number
  sport: string
  type: string
  duration: number
  status: string

  constructor(
    id: number,
  sport: string,
  type: string,
  duration: number,
  status: string
  ) {
    this.id = id
    this.sport = sport
    this.type = type
    this.duration = duration
    this.status = status
  }
}