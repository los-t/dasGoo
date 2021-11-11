options indenting = 2

require daslib/media
require daslib/decs_boost

require resources

require drawable
require bullet
require movement
require playerInput


def spawn_player(at: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position x = at.x, y = at.y]])
    apply_decs_template(comp, [[Velocity]])
    apply_decs_template(comp, [[MovementLimits x = float(get_screen_width()),
                                               y = float(get_screen_height())]])
    apply_decs_template(comp, [[PlayerInput]])
    apply_decs_template(comp, [[Drawable sprite = tex]])


[decs(stage = apply_input)]
def apply_player_input(var vel: Velocity; pos: Position; input: PlayerInput)
  vel.x += input.dir.x
  vel.y += input.dir.y
  if (input.fire)
    spawn_bullet(float2(pos.x, pos.y), float2(vel.x * 10.0, vel.y * 10.0), get_image("bullet"))
