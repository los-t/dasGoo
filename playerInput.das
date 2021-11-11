options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct PlayerInput
  dir: float2
  fire: bool


[decs(stage = input)]
def update_player_input(var input: PlayerInput)
  input.dir.x = get_key(VK_L) ? 1.0 : 0.0
  input.dir.x += get_key(VK_H) ? -1.0 : 0.0
  input.dir.y = get_key(VK_K) ? 1.0 : 0.0
  input.dir.y += get_key(VK_J) ? -1.0 : 0.0
  input.fire = get_key(VK_SPACE)
