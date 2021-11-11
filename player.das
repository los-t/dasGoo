options indenting = 2

require daslib/media
require daslib/decs_boost

require bullet
require movement
require playerInput


def spawn_player(at: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Movement pos = at]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[PlayerInput]])


[decs(stage = apply_input)]
def apply_player_input(var m: Movement; input: PlayerInput)
  m.vel += input.dir
  if (input.fire)
    spawn_bullet(m.pos, m.vel * 10.0)


[decs(stage = draw)]
def draw_player(m: Movement; i: PlayerInput)
  fill_circle(m.pos.x, m.pos.y, 10.0, 0xFFFFFFFF)
