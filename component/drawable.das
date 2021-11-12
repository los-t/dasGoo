options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require movement
require orientation

[decs_template]
struct Drawable
  sprite: ImageHandle


[decs(stage = draw)]
def draw_sprite(p: Position; o: Orientation; img: Drawable)
  let size = float2(float(img.sprite.width), float(img.sprite.height))
  let angle = 0.5*PI - atan2(-o.dir.y, o.dir.x)
  let rect = float4(0.0, 0.0, size.x, size.y)
  draw_image_transformed(img.sprite, p.pos.x, p.pos.y, rect, 0xFFFFFFFF, size, angle)

