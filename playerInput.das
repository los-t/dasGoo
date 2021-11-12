options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct PlayerInput
  strafe: float
  throttle: float
  yaw: float
  fire: bool

let
  DIR_NORTH = float2( 0.0, 1.0)
  DIR_SOUTH = float2( 0.0,-1.0)
  DIR_EAST  = float2( 1.0, 0.0)
  DIR_WEST  = float2(-1.0, 0.0)
  ROT_DELTA = 0.01 * PI

let directions <- {{VK_H => DIR_WEST; VK_J => DIR_SOUTH; VK_K => DIR_NORTH; VK_L => DIR_EAST}}
let rotations <- {{VK_Y => -ROT_DELTA; VK_O => ROT_DELTA}}

[decs(stage = read_input)]
def update_player_input(var input: PlayerInput)
  input.strafe = 0.0
  input.throttle = 0.0
  for k, v in keys(directions), values(directions)
    let dir = get_key(k) ? v : float2()
    input.throttle += dir.y
    input.strafe += dir.x

  input.throttle += -get_axis(AXIS_PRIMARY_Y)
  input.strafe += get_axis(AXIS_PRIMARY_X)

  input.yaw = 0.0
  for k, v in keys(rotations), values(rotations)
    input.yaw += get_key(k) ? v : 0.0

  var dir = float2(get_axis(AXIS_SECONDARY_X), get_axis(AXIS_SECONDARY_Y))
  let rot = dot(dir, float2(1.0, 0.0))
  input.yaw += rot * ROT_DELTA

  let triggerThres = 0.3
  let rt = -1.0 * clamp(get_axis(AXIS_TRIGGERS), -1.0, 0.0)
  input.fire = get_key(VK_SPACE) || (rt > triggerThres)
