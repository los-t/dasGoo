options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require drawable
require movement

[decs_template]
struct Bullet
  maxRange: float
  lifetime: float
  damage: float

let BULLET_MAX_RANGE = 1280.0
let BULLET_LIFETIME = 30.0
let BULLET_DAMAGE = 1.5

def spawn_bullet(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity x = vel.x, y = vel.y]])
    apply_decs_template(comp, [[Bullet maxRange = BULLET_MAX_RANGE,
                                       lifetime = BULLET_LIFETIME,
                                       damage = BULLET_DAMAGE]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


[decs(stage = update)]
def update_bullet(var b: Bullet; vel: Velocity; eid: EntityId)
  let dt = get_delta_time()
  let delta = float2(vel.x * dt, vel.y * dt)
  b.maxRange -= length(delta)
  b.lifetime -= dt
  if (b.maxRange < 0.0 || b.lifetime < 0.0)
    delete_entity(eid)


[decs(stage = draw)]
def draw_bullet(pos: Position; tag: Bullet)
  fill_circle(pos.x, pos.y, 2.0, 0xFFFF0000)
