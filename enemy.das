options indenting = 2

require daslib/media
require daslib/decs_boost

require component/drawable
require component/orientation
require component/movement
require component/health
require component/shot
require component/screenBounce
require component/collision

let ENEMY_INITIAL_HEALTH = 10.0

def spawn_enemy(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation]])
    apply_decs_template(comp, [[Velocity vel = vel]])
    apply_decs_template(comp, [[ScreenBounce offset = float2(tex.width/2, tex.height/2)]])
    apply_decs_template(comp, [[Health hp = ENEMY_INITIAL_HEALTH]])
    apply_decs_template(comp, [[Drawable sprite = tex]])
    apply_decs_template(comp, [[Collision radius = 0.5 * float(max(tex.width, tex.height))]])


def is_hit(proj, recp, size: float2)
  let halfSize = 0.5 * size
  let h = (proj.x >= recp.x - halfSize.x) && (proj.x <= recp.x + halfSize.x)
  let v = (proj.y >= recp.y - halfSize.y) && (proj.y <= recp.y + halfSize.y)
  return h && v


[decs(stage = update)]
def update_enemy(var enemy: Health; p: Position; img: Drawable; eid: EntityId)
  query() <| $(var shot: Shot; at: Position)
    if (is_hit(at.pos, p.pos, float2(img.sprite.width, img.sprite.height)))
      enemy.hp -= shot.damage
      shot.damage = 0.0
