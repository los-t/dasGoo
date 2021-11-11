options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct Position
  x, y: float

[decs_template]
struct Velocity
  x, y: float

[decs(stage = move)]
def apply_movement(var pos: Position; vel: Velocity)
  let dt = get_delta_time()
  pos.x += vel.x * dt
  pos.y += vel.y * dt


[decs_template]
struct MovementLimits
  x: float
  y: float

[decs(stage = move)]
def apply_movement_limits(var vel: Velocity; pos: Position; lim: MovementLimits)
  vel.x *= (pos.x >= lim.x || pos.x <= 0.0) ? -1.0 : 1.0
  vel.y *= (pos.y >= lim.y || pos.y <= 0.0) ? -1.0 : 1.0
