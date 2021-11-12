options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require movement
require orientation

[decs_template]
struct Drawable
  sprite: ImageHandle

def do_draw(pos, dir: float2; img: ImageHandle)
  let size = float2(float(img.width), float(img.height))
  let angle = 0.5*PI - atan2(-dir.y, dir.x)
  let rect = float4(0.0, 0.0, size.x, size.y)
  draw_image_transformed(img, pos.x, pos.y, rect, 0xFFFFFFFF, size, angle)

[decs_template]
struct DrawLast
  tag: int

[decs(stage = draw_last)]
def draw_last(p: Position; o: Orientation; img: Drawable; tag: DrawLast)
  do_draw(p.pos, o.dir, img.sprite)


[decs_template]
struct DrawFirst
  tag: int

[decs(stage = draw_first)]
def draw_first(p: Position; o: Orientation; img: Drawable; tag: DrawFirst)
  do_draw(p.pos, o.dir, img.sprite)

