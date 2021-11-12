options indenting = 2

require daslib/media
require daslib/decs_boost

require resources

require drawable
require projectile
require movement
require orientation
require playerInput


def spawn_player(at: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Velocity]])
    apply_decs_template(comp, [[Orientation dir = float2(1.0, 0.0)]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[PlayerInput]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


def rotate(var v: float2; a: float)
  var sn, cs: float
  sincos(a, sn, cs)
  v.x = v.x * cs - v.y * sn
  v.y = v.x * sn + v.y * cs
  return v


[decs(stage = apply_input)]
def apply_player_input(var v: Velocity; var o: Orientation; p: Position; input: PlayerInput)
  o.dir = rotate(o.dir, input.yaw)
  normalize(o.dir)
  v.vel.x += input.throttle
  v.vel.y += input.strafe
  let speed = length(v.vel)
  if (input.fire)
    spawn_projectile(p.pos, o.dir, speed, get_image("laser"))
