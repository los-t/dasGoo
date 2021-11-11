options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct PlayerInput
  dir: float2
  fire: bool

let
  DIR_NORTH = float2( 0.0,-1.0)
  DIR_SOUTH = float2( 0.0, 1.0)
  DIR_EAST  = float2( 1.0, 0.0)
  DIR_WEST  = float2(-1.0, 0.0)

let directions <- {{VK_H => DIR_WEST; VK_J => DIR_SOUTH; VK_K => DIR_NORTH; VK_L => DIR_EAST}}

[decs(stage = read_input)]
def update_player_input(var input: PlayerInput)
  input.dir = float2()
  for k, a in keys(directions), values(directions)
    input.dir += get_key(k) ? a : float2()
  input.fire = get_key(VK_SPACE)
