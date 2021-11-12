options indenting = 2

require daslib/media
require daslib/decs_boost

require drawable
require projectile
require movement

[decs_template]
struct Enemy
  hp: float

let ENEMY_INITIAL_HEALTH = 10.0

def spawn_enemy(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity x = vel.x, y = vel.y]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[Enemy hp = ENEMY_INITIAL_HEALTH]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


[decs(stage = update)]
def update_enemy(var enemy: Enemy; pos: Position; img: Drawable; eid: EntityId)
  if (enemy.hp <= 0.0)
    delete_entity(eid)
  query() <| $(var p: Projectile; at: Position)
    let halfSize = float2(0.5 * float(img.sprite.width), 0.5 * float(img.sprite.height))
    let h = (at.x >= pos.x - halfSize.x) && (at.x <= pos.x + halfSize.x)
    let v = (at.y >= pos.y - halfSize.y) && (at.y <= pos.y + halfSize.y)
    let isHit = h && v
    if (isHit)
      enemy.hp -= p.damage
      p.lifetime = 0.0
