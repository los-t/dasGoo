options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

[decs_template]
struct Bullet
  pos: float2
  vel: float2
  maxRange: float
  lifetime: float

let BULLET_MAX_RANGE = 1280.0
let BULLET_LIFETIME = 30.0

def spawn_bullet(at, initial_vel: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp,
                        [[Bullet pos = at,
                                 vel = initial_vel,
                                 maxRange = BULLET_MAX_RANGE,
                                 lifetime = BULLET_LIFETIME]])


[decs(stage = update)]
def update_bullet(var b: Bullet; eid: EntityId)
  let dt = get_delta_time()
  let delta = b.vel * dt
  b.pos += delta
  b.maxRange -= length(delta)
  b.lifetime -= dt
  if (b.maxRange < 0.0 || b.lifetime < 0.0)
    delete_entity(eid)


[decs(stage = draw)]
def draw_bullet(b: Bullet)
  text_out(20, 60, "player bullet {b.lifetime} {b.maxRange} {b.vel}", 0xFFFFFFFF)
  fill_circle(b.pos.x, b.pos.y, 2.0, 0xFFFF0000)
