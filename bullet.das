options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require movement

[decs_template]
struct Bullet
  maxRange: float
  lifetime: float
  damage: float

let BULLET_MAX_RANGE = 1280.0
let BULLET_LIFETIME = 30.0
let BULLET_DAMAGE = 1.5

def spawn_bullet(at, vel: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Movement pos = at, vel = vel]])
    apply_decs_template(comp, [[Bullet maxRange = BULLET_MAX_RANGE,
                                       lifetime = BULLET_LIFETIME,
                                       damage = BULLET_DAMAGE]])


[decs(stage = update)]
def update_bullet(var b: Bullet; m: Movement; eid: EntityId)
  let dt = get_delta_time()
  let delta = m.vel * dt
  b.maxRange -= length(delta)
  b.lifetime -= dt
  if (b.maxRange < 0.0 || b.lifetime < 0.0)
    delete_entity(eid)


[decs(stage = draw)]
def draw_bullet(b: Bullet; m: Movement)
  fill_circle(m.pos.x, m.pos.y, 2.0, 0xFFFF0000)
