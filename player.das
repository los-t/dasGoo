options indenting = 2

require daslib/media
require daslib/decs_boost

require bullet
require playerInput

[decs_template]
struct Player
  pos: float2
  vel: float2


def spawn_player(at: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Player pos = at]])
    apply_decs_template(comp, [[PlayerInput]])


[decs(stage = update)]
def update_player(var p: Player; input: PlayerInput)
  let dt = get_delta_time()
  let limits = float2(float(get_screen_width()), float(get_screen_height()))
  p.vel += input.dir
  p.pos += p.vel * dt
  if (p.pos.x >= limits.x || p.pos.x <= 0.0)
    p.vel.x *= -1.0
  if (p.pos.y >= limits.y || p.pos.y <= 0.0)
    p.vel.y *= -1.0

  if (input.fire)
    spawn_bullet(p.pos, p.vel * 10.0)


[decs(stage = draw)]
def draw_player(p: Player)
  text_out(20, 40, "player pos {p.pos} {p.vel}", 0xFFFFFFFF)
  fill_circle(p.pos.x, p.pos.y, 10.0, 0xFFFFFFFF)
