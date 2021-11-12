options indenting = 2

require daslib/media
require daslib/decs_boost

require player
require enemy
require resources
require weaponry
require sky
require debug


let imagePaths <- {{ "player" => "res/playerShip3_red.png";
                     "laser" => "res/laserRed07.png";
                     "star" => "res/blackSmoke10.png";
                     "enemy"  => "res/ufoGreen.png" }}

let INIT_WAVE_DELTA = 3.0
let INIT_WAVE_COUNT = 10
let MAX_WAVE_COUNT = 50
var timeToNextWave: float
var enemyCount: int

[export]
def initialize(is_hard_reload: bool)
  disable_auto_upscale()
  set_window_title("DasHackathon")

  load_images(imagePaths)
  load_sky()

  timeToNextWave = INIT_WAVE_DELTA
  enemyCount = INIT_WAVE_COUNT

  restart()
  spawn_sky(25)
  spawn_player(float2(100.0, 0.5 * float(get_screen_height())), get_image("player"))
  spawn_enemy_wave(enemyCount)
  commit()


[export]
def act(dt: float)
  timeToNextWave -= dt
  if (timeToNextWave <= 0.0)
    spawn_enemy_wave(enemyCount)
    enemyCount += min(enemyCount / 2, MAX_WAVE_COUNT)
    timeToNextWave = 2.0 * INIT_WAVE_DELTA * float(enemyCount/INIT_WAVE_COUNT)

  update_debug_toggles()
  decs_stage("read_input")
  decs_stage("apply_input")
  decs_stage("update")
  decs_stage("move")


[export]
def draw()
  enable_alpha_blend()
  decs_stage("draw_background")
  decs_stage("draw_first")
  decs_stage("draw_last")
  if (isDebugDrawEnabled)
    decs_stage("debug_draw")
  disable_alpha_blend()
