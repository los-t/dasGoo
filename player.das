options indenting = 2

require daslib/media
require daslib/decs_boost

require bullet
require movement
require playerInput


def spawn_player(at: float2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[PlayerInput]])


[decs(stage = apply_input)]
def apply_player_input(var vel: Velocity; pos: Position; input: PlayerInput)
  vel.x += input.dir.x
  vel.y += input.dir.y
  if (input.fire)
    spawn_bullet(float2(pos.x, pos.y), float2(vel.x * 10.0, vel.y * 10.0))


[decs(stage = draw)]
def draw_player(pos: Position; tag: PlayerInput)
  fill_circle(pos.x, pos.y, 10.0, 0xFFFFFFFF)
