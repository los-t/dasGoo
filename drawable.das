options indenting = 2

require daslib/media
require daslib/decs_boost

require movement

[decs_template]
struct Drawable
  sprite: ImageHandle

[decs(stage = draw)]
def draw_sprites(pos: Position; img: Drawable)
  let w = float(img.sprite.width)
  let h = float(img.sprite.height)
  let center = float2(pos.x - 0.5 * w, pos.y - 0.5 * h)
  draw_image(img.sprite, center.x, center.y)

