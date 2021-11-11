options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct Movement
  pos: float2
  vel: float2

[decs(stage = move)]
def apply_movement(var m: Movement)
  let dt = get_delta_time()
  m.pos += m.vel * dt


[decs_template]
struct MovementLimits
  x: float
  y: float

[decs(stage = move)]
def apply_movement_limits(var m: Movement; lim: MovementLimits)
  m.vel.x *= (m.pos.x >= lim.x || m.pos.x <= 0.0) ? -1.0 : 1.0
  m.vel.y *= (m.pos.y >= lim.y || m.pos.y <= 0.0) ? -1.0 : 1.0
