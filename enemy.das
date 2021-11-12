options indenting = 2

require daslib/media
require daslib/random
require daslib/decs_boost

require resources
require grid

require component/drawable
require component/orientation
require component/movement
require component/health
require component/screenBounce
require component/collision

let ENEMY_INITIAL_HEALTH = 10.0
var ENEMY_SPAWN_SEED = random_seed(13564242)

def spawn_enemy(at, vel: float2; var tex: ImageHandle)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation]])
    apply_decs_template(comp, [[Velocity vel = vel]])
    apply_decs_template(comp, [[ScreenBounce offset = float2(tex.width/2, tex.height/2)]])
    apply_decs_template(comp, [[Health hp = ENEMY_INITIAL_HEALTH]])
    apply_decs_template(comp, [[Drawable sprite = tex, color = COLOR_WHITE]])
    apply_decs_template(comp, [[DrawLast]])
    apply_decs_template(comp, [[Collision radius = 0.5 * float(max(tex.width, tex.height))]])


def spawn_enemy_wave(count: int)
  var grid <- make_grid(count, 50)
  var i = 0
  while i < count
    let cell = floori(random_float(ENEMY_SPAWN_SEED) * float(length(grid)))
    let pos = grid[cell]
    if (length(pos) > 0.0)
      let vel = 30.0 * random_float(ENEMY_SPAWN_SEED) * float2(1, 0)
      spawn_enemy(pos, vel, get_image("enemy"))
      grid[cell] = float2()
      i++
  
