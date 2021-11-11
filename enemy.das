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
    apply_decs_template(comp, [[Movement pos = at, vel = vel]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp,
                        [[Enemy hp = ENEMY_INITIAL_HEALTH]])


def is_hit(enemy, bullet: float2)
  let halfSize = 0.5 * ENEMY_SIZE
  let h = (bullet.x >= enemy.x - halfSize) && (bullet.x <= enemy.x + halfSize)
  let v = (bullet.y >= enemy.y - halfSize) && (bullet.y <= enemy.y + halfSize)
  return h && v


[decs(stage = update)]
def update_enemy(var enemy: Enemy; m: Movement; eid: EntityId)
  if (enemy.hp <= 0.0)
    delete_entity(eid)
  query() <| $(var b: Bullet; bullet: Movement)
    if (is_hit(m.pos, bullet.pos))
      enemy.hp -= b.damage
      b.lifetime = 0.0


[decs(stage = draw)]
def draw_enemies(m: Movement; enemy: Enemy)
  let initialAlpha = 0xFF000000
  let initialColor = 0x000000FF
  let fade = enemy.hp / ENEMY_INITIAL_HEALTH
  let color = initialColor + uint(float(initialAlpha) * fade)
  let halfSize = 0.5 * ENEMY_SIZE
  fill_rect(m.pos.x - halfSize, m.pos.y - halfSize, ENEMY_SIZE, ENEMY_SIZE, color)
