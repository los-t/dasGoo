options indenting = 2

require daslib/math
require daslib/media
require daslib/decs_boost

require movement

[decs_template]
struct RangedShot
  maxRange: float
  lifetime: float


[decs(stage = update)]
def update_ranged_shot(var s: RangedShot; v: Velocity)
  let dt = get_delta_time()
  let delta = v.vel * dt
  s.maxRange -= length(delta)
  s.lifetime -= dt


[decs(stage = update)]
def delete_expired_ranged_shots(s: RangedShot; eid: EntityId)
  if (s.maxRange < 0.0 || s.lifetime < 0.0)
    delete_entity(eid)
