options indenting = 2

require daslib/math
require daslib/decs_boost

require movement

[decs_template]
struct Collision
  radius: float


[decs(stage = update)]
def brute_force_collision(var v: Velocity; p: Position; c: Collision)
  query() <| $(var v2: Velocity; p2: Position; c2: Collision)
    let collided = length(p2.pos - p.pos) <= (c.radius + c2.radius)
    if (collided)
      let totalVel = v.vel + v2.vel
      v.vel = 0.5 * totalVel
      v2.vel = v.vel
