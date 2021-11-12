options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require movement
require orientation

let COLOR_WHITE = 0xFFFFFFFF

[decs_template]
struct Drawable
  sprite: ImageHandle
  color: uint

def do_draw(pos, dir: float2; img: ImageHandle; color: uint)
  let size = float2(float(img.width), float(img.height))
  let angle = 0.5*PI - atan2(-dir.y, dir.x)
  let rect = float4(0.0, 0.0, size.x, size.y)
  draw_image_transformed(img, pos.x, pos.y, rect, color, size, angle)

[decs_template]
struct DrawBackground
  tag: int

[decs(stage = draw_background)]
def draw_background(p: Position; o: Orientation; img: Drawable; tag: DrawBackground)
  do_draw(p.pos, o.dir, img.sprite, img.color)


[decs_template]
struct DrawFirst
  tag: int

[decs(stage = draw_first)]
def draw_first(p: Position; o: Orientation; img: Drawable; tag: DrawFirst)
  do_draw(p.pos, o.dir, img.sprite, img.color)


[decs_template]
struct DrawLast
  tag: int

[decs(stage = draw_last)]
def draw_last(p: Position; o: Orientation; img: Drawable; tag: DrawLast)
  do_draw(p.pos, o.dir, img.sprite, img.color)
