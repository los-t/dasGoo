options indenting = 2

require daslib/media

var lastDt: float


[export]
def initialize(is_hard_reload: bool)
  disable_auto_upscale()
  set_window_title("DasHackathon")


[export]
def act(dt: float)
  lastDt = dt


[export]
def draw()
  text_out(20, 20, "last dt = {lastDt}", 0xFFFFFFFF)
