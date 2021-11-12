options indenting = 2

require daslib/media
require daslib/decs_boost

require drawable
require projectile
require orientation
require movement

[decs_template]
struct Enemy
  hp: float

let ENEMY_INITIAL_HEALTH = 10.0

def spawn_enemy(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation]])
    apply_decs_template(comp, [[Velocity vel = vel]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[Enemy hp = ENEMY_INITIAL_HEALTH]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


def is_hit(proj, recp, size: float2)
  let halfSize = 0.5 * size
  let h = (proj.x >= recp.x - halfSize.x) && (proj.x <= recp.x + halfSize.x)
  let v = (proj.y >= recp.y - halfSize.y) && (proj.y <= recp.y + halfSize.y)
  return h && v


[decs(stage = update)]
def update_enemy(var enemy: Enemy; p: Position; img: Drawable; eid: EntityId)
  if (enemy.hp <= 0.0)
    delete_entity(eid)
  query() <| $(var proj: Projectile; at: Position)
    if (is_hit(at.pos, p.pos, float2(img.sprite.width, img.sprite.height)))
      enemy.hp -= proj.damage
      proj.lifetime = 0.0
