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
def draw_sprite(pos: Position; o: Orientation; img: Drawable)
  let size = float2(float(img.sprite.width), float(img.sprite.height))
  let angle = atan2(o.dir.x, o.dir.y)
  let rect = float4(0.0, 0.0, size.x, size.y)
  draw_image_transformed(img.sprite, pos.x, pos.y, rect, 0xFFFFFFFF, size, angle)

