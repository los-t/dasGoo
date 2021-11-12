options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct Position
  pos: float2

[decs_template]
struct Velocity
  vel: float2

[decs(stage = move)]
def apply_movement(var p: Position; v: Velocity)
  let dt = get_delta_time()
  p.pos += v.vel * dt


[decs_template]
struct MovementLimits
  x: float
  y: float

[decs(stage = move)]
def apply_movement_limits(var v: Velocity; p: Position; lim: MovementLimits)
  v.vel.x *= (p.pos.x >= lim.x || p.pos.x <= 0.0) ? -1.0 : 1.0
  v.vel.y *= (p.pos.y >= lim.y || p.pos.y <= 0.0) ? -1.0 : 1.0
