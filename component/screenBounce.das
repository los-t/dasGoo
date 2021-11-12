options indenting = 2

require daslib/media
require daslib/decs_boost

require movement

[decs_template]
struct ScreenBounce
  offset: float2


[decs(stage = move)]
def bounce_off_screen(var v: Velocity; p: Position; b: ScreenBounce)
  let w = float(get_screen_width())
  let h = float(get_screen_height())
  let hor = float2(b.offset.x, w - b.offset.x)
  let ver = float2(b.offset.y, h - b.offset.y)
  v.vel.x *= (p.pos.x >= hor.y || p.pos.x <= hor.x) ? -1.0 : 1.0
  v.vel.y *= (p.pos.y >= ver.y || p.pos.y <= ver.x) ? -1.0 : 1.0
