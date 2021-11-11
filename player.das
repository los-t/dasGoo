options indenting = 2

require daslib/media
require daslib/decs_boost

[decs_template]
struct Player
  pos: float2
  vel: float2


def spawn_player(at: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Player pos = at, vel = float2(100.0, 200.0)]])


[decs(stage = update)]
def update_player(var p: Player)
  let dt = get_delta_time()
  let limits = float2(float(get_screen_width()), float(get_screen_height()))
  p.pos += p.vel * dt
  p.pos.x = clamp(p.pos.x, 0.0, limits.x)
  p.pos.y = clamp(p.pos.y, 0.0, limits.y)


[decs(stage = draw)]
def draw_player(var p: Player)
  text_out(20, 40, "player pos {p.pos}", 0xFFFFFFFF)
  fill_circle(p.pos.x, p.pos.y, 10.0, 0xFFFFFFFF)
