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
