options indenting = 2

require daslib/media
require daslib/decs_boost

require bullet
require movement

[decs_template]
struct Enemy
  hp: float

let ENEMY_INITIAL_HEALTH = 10.0
let ENEMY_SIZE = 15.0

def spawn_enemy(at, vel: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity x = vel.x, y = vel.y]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp,
                        [[Enemy hp = ENEMY_INITIAL_HEALTH]])


[decs(stage = update)]
def update_enemy(var enemy: Enemy; pos: Position; eid: EntityId)
  if (enemy.hp <= 0.0)
    delete_entity(eid)
  query() <| $(var b: Bullet; bullet: Position)
    let halfSize = 0.5 * ENEMY_SIZE
    let h = (bullet.x >= pos.x - halfSize) && (bullet.x <= pos.x + halfSize)
    let v = (bullet.y >= pos.y - halfSize) && (bullet.y <= pos.y + halfSize)
    let isHit = h && v
    if (isHit)
      enemy.hp -= b.damage
      b.lifetime = 0.0


[decs(stage = draw)]
def draw_enemy(pos: Position; enemy: Enemy)
  let initialAlpha = 0xFF000000
  let initialColor = 0x000000FF
  let fade = enemy.hp / ENEMY_INITIAL_HEALTH
  let color = initialColor + uint(float(initialAlpha) * fade)
  let halfSize = 0.5 * ENEMY_SIZE
  fill_rect(pos.x - halfSize, pos.y - halfSize, ENEMY_SIZE, ENEMY_SIZE, color)
