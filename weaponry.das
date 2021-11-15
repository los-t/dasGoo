options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require resources

require component/movement
require component/orientation
require component/shot
require component/rangedShot
require component/drawable
require component/health
require component/gun

let PROJECTILE_SPEED = 200.0
let PROJECTILE_MAX_RANGE = 0.7 * float(get_screen_width())
let PROJECTILE_LIFETIME = 30.0
let PROJECTILE_DAMAGE = 1.5

def spawn_projectile(at, dir: float2; speed: float; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation dir = dir]])
    apply_decs_template(comp, [[Velocity vel = dir * (speed + PROJECTILE_SPEED)]])
    apply_decs_template(comp, [[RangedShot maxRange = PROJECTILE_MAX_RANGE,
                                           lifetime = PROJECTILE_LIFETIME]])
    apply_decs_template(comp, [[Shot damage = PROJECTILE_DAMAGE]])
    apply_decs_template(comp, [[Drawable sprite = tex, color = 0xA0FFFFFF, scale = 0.8]])
    apply_decs_template(comp, [[DrawFirst]])


[decs(stage = update)]
def shoot_gun(var g: Gun; p: Position; o: Orientation; v: Velocity)
  if (g.triggered)
    let gunPoint = p.pos + g.offset * o.dir
    let speed = dot(v.vel, o.dir)
    spawn_projectile(gunPoint, o.dir, speed, get_image("laser"))
  g.triggered = false


def is_hit(proj, recp, size: float2)
  let halfSize = 0.5 * size
  let hitRadius = min(halfSize.x, halfSize.y) * 0.8
  return length(recp - proj) <= hitRadius


[decs(stage = update)]
def deal_weapon_damage(var enemy: Health; p: Position; img: Drawable; eid: EntityId)
  query() <| $(var shot: Shot; at: Position)
    if (is_hit(at.pos, p.pos, img.scale * float2(img.sprite.width, img.sprite.height)))
      enemy.hp -= shot.damage
      shot.damage = 0.0
