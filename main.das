options indenting = 2

require daslib/media
require daslib/decs_boost

require player

var lastDt: float


[export]
def initialize(is_hard_reload: bool)
  disable_auto_upscale()
  set_window_title("DasHackathon")

  restart()
  spawn_player(float2(100, 100))
  commit()


[export]
def act(dt: float)
  lastDt = dt
  decs_stage("input")
  decs_stage("update")


[export]
def draw()
  decs_stage("draw")
  text_out(20, 20, "last dt = {lastDt}", 0xFFFFFFFF)
