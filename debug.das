options indenting = 2

require daslib/media
require daslib/decs_boost

require movement

var isDebugDrawEnabled: bool

def update_debug_toggles()
  if (get_key_up(VK_F12))
    isDebugDrawEnabled = !isDebugDrawEnabled

[decs(stage = debug_draw)]
def draw_positions(pos: Position)
  circle(pos.x, pos.y, 10.0, 0xFF00FF00)
