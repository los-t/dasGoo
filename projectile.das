options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require component/drawable
require component/orientation
require component/movement
require component/rangedShot
require component/shot

let PROJECTILE_SPEED = 100.0
let PROJECTILE_MAX_RANGE = 1280.0
let PROJECTILE_LIFETIME = 30.0
let PROJECTILE_DAMAGE = 1.5

def spawn_projectile(at, dir: float2; speed: float; var tex: ImageHandle)
  let v = speed + PROJECTILE_SPEED
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation dir = dir]])
    apply_decs_template(comp, [[Velocity vel = dir * v]])
    apply_decs_template(comp, [[RangedShot maxRange = PROJECTILE_MAX_RANGE,
                                           lifetime = PROJECTILE_LIFETIME]])
    apply_decs_template(comp, [[Shot damage = PROJECTILE_DAMAGE]])
    apply_decs_template(comp, [[Drawable sprite = tex]])
