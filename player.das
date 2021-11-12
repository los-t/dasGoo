options indenting = 2

require daslib/media
require daslib/decs_boost

require component/drawable
require component/movement
require component/orientation
require component/playerInput
require component/screenBounce
require component/collision
require component/gun


def spawn_player(at: float2; var tex: ImageHandle)
  let halfSize = float2(tex.width/2, tex.height/2)
  let gunPointOffset = halfSize.y
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Velocity]])
    apply_decs_template(comp, [[Orientation dir = float2(1.0, 0.0)]])
    apply_decs_template(comp, [[ScreenBounce offset = halfSize]])
    apply_decs_template(comp, [[PlayerInput]])
    apply_decs_template(comp, [[Drawable sprite = tex, color = COLOR_WHITE]])
    apply_decs_template(comp, [[DrawLast]])
    apply_decs_template(comp, [[Collision radius = 0.5 * max(halfSize.x, halfSize.y)]])
    apply_decs_template(comp, [[Gun offset = gunPointOffset]])


def rotate(v: float2; a: float)
  var sn, cs: float
  sincos(a, sn, cs)
  return float2(v.x * cs - v.y * sn, v.x * sn + v.y * cs)


[decs(stage = apply_input)]
def apply_player_input(var v: Velocity; var o: Orientation; var g: Gun; p: Position; input: PlayerInput)
  o.dir = rotate(o.dir, input.yaw)
  normalize(o.dir)
  v.vel += o.dir * input.throttle + rotate(o.dir, 0.5*PI) * input.strafe
  g.triggered = input.fire
