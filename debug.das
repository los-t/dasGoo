options indenting = 2

require daslib/media
require daslib/decs_boost

require movement
require orientation

var isDebugDrawEnabled: bool

def update_debug_toggles()
  if (get_key_up(VK_F12))
    isDebugDrawEnabled = !isDebugDrawEnabled


[decs(stage = debug_draw)]
def draw_positions(p: Position; o: Orientation)
  let posRadius = 10.0
  circle(p.pos.x, p.pos.y, posRadius, 0xFF00FF00)
  for i in range(1, 4)
    let radius = 2.0
    let offset = o.dir * float(i) * (radius * posRadius)
    circle(p.pos.x + offset.x, p.pos.y + offset.y, radius, 0xFFFFFF00)


[decs(stage = debug_draw)]
def draw_velocities(p: Position; v: Velocity)
  fill_rect(p.pos.x + v.vel.x, p.pos.y + v.vel.y, 3.0, 3.0, 0xFFFF00FF)
