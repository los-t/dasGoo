options indenting = 2

require daslib/media
require daslib/decs_boost

require player
require enemy
require resources

var lastDt: float

let imagePaths <- {{ "player" => "res/playerShip3_red.png";
                     "laser" => "res/laserRed07.png";
                     "enemy"  => "res/ufoGreen.png" }}

[export]
def initialize(is_hard_reload: bool)
  disable_auto_upscale()
  set_window_title("DasHackathon")

  load_images(imagePaths)

  restart()
  spawn_player(float2(100, 100), get_image("player"))
  for i in range(0, 10)
    spawn_enemy(float2(i * 100, i * 20), float2(5.0, 1.5), get_image("enemy"))
  commit()


[export]
def act(dt: float)
  lastDt = dt
  decs_stage("read_input")
  decs_stage("apply_input")
  decs_stage("update")
  decs_stage("move")


[export]
def draw()
  enable_alpha_blend()
  decs_stage("draw")
  disable_alpha_blend()
  text_out(20, 20, "last dt = {lastDt}", 0xFFFFFFFF)
