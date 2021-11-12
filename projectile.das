options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require drawable
require movement

[decs_template]
struct Projectile
  maxRange: float
  lifetime: float
  damage: float

let PROJECTILE_MAX_RANGE = 1280.0
let PROJECTILE_LIFETIME = 30.0
let PROJECTILE_DAMAGE = 1.5

def spawn_projectile(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity x = vel.x, y = vel.y]])
    apply_decs_template(comp, [[Projectile maxRange = PROJECTILE_MAX_RANGE,
                                           lifetime = PROJECTILE_LIFETIME,
                                           damage = PROJECTILE_DAMAGE]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


[decs(stage = update)]
def update_projectile(var p: Projectile; vel: Velocity; eid: EntityId)
  let dt = get_delta_time()
  let delta = float2(vel.x * dt, vel.y * dt)
  p.maxRange -= length(delta)
  p.lifetime -= dt
  if (p.maxRange < 0.0 || p.lifetime < 0.0)
    delete_entity(eid)
