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

let enemyTexKeys = [[string[4] "enemy0"; "enemy1"; "enemy2"; "enemy3" ]]
let enemyTextures <- {{ enemyTexKeys[0] => "res/fart01.png";
                        enemyTexKeys[1] => "res/fart03.png";
                        enemyTexKeys[2] => "res/fart02.png";
                        enemyTexKeys[3] => "res/fart05.png" }}

def load_enemies()
  load_images(enemyTextures)


def spawn_enemy(at, vel: float2; var tex: ImageHandle)
  let scale = 0.1
  let halfSize = scale * float2(tex.width/2, tex.height/2)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation]])
    apply_decs_template(comp, [[Velocity vel = vel]])
    apply_decs_template(comp, [[ScreenBounce offset = halfSize]])
    apply_decs_template(comp, [[Health hp = ENEMY_INITIAL_HEALTH]])
    apply_decs_template(comp, [[Drawable sprite = tex, color = 0xAADF23FF, scale = scale]])
    apply_decs_template(comp, [[DrawLast]])
    apply_decs_template(comp, [[Collision radius = 0.5 * max(halfSize.x, halfSize.y)]])


def spawn_enemy_wave(count: int)
  var grid <- make_grid(count, 50)
  var i = 0
  while i < count
    let rnd = random_float(ENEMY_SPAWN_SEED)
    let cell = floori(rnd * float(length(grid)))
    let pos = grid[cell]
    if (length(pos) > 0.0)
      let vel = 90.0 * (1.0 - rnd) * float2(1, 0)
      let tex = floori(rnd * float(length(enemyTexKeys)))
      spawn_enemy(pos, vel, get_image(enemyTexKeys[tex]))
      grid[cell] = float2()
      i++
  
