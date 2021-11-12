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
def draw_positions(pos: Position; o: Orientation)
  let posRadius = 10.0
  circle(pos.x, pos.y, posRadius, 0xFF00FF00)
  for i in range(1, 4)
    let radius = 2.0
    let offset = o.dir * float(i) * (radius * posRadius)
    circle(pos.x + offset.x, pos.y + offset.y, radius, 0xFFFFFF00)
