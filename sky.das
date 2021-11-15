options indenting = 2

require daslib/media
require daslib/decs_boost

require resources
require grid

require component/movement
require component/orientation
require component/drawable

var STAR_SPAWN_SEED = random_seed(4242)

let skyTexKeys = [[string[4] "cloud0"; "cloud1"; "cloud2"; "cloud3" ]]
let skyTextures <- {{ skyTexKeys[0] => "res/blackSmoke10.png";
                      skyTexKeys[1] => "res/blackSmoke16.png";
                      skyTexKeys[2] => "res/blackSmoke19.png";
                      skyTexKeys[3] => "res/blackSmoke20.png" }}

def load_sky()
  load_images(skyTextures)


def spawn_nebula(at: float2; var tex: ImageHandle)
  let dir = float2(random_float(STAR_SPAWN_SEED), random_float(STAR_SPAWN_SEED))
  let color = uint(random_float(STAR_SPAWN_SEED) * float(0xAA000000)) + 0x00FFFFFF
  normalize(dir)
  create_entity <| @(eid, comp)
    set(comp, "eid", eid)
    apply_decs_template(comp, [[Position pos = at]])
    apply_decs_template(comp, [[Orientation dir = dir]])
    apply_decs_template(comp, [[Drawable sprite = tex, color = color, scale = 1.0]])
    apply_decs_template(comp, [[DrawBackground]])


def spawn_sky(count: int)
  var grid <- make_grid(count, 0)
  var i = 0
  while i < count
    let rnd = random_float(STAR_SPAWN_SEED)
    let cell = floori(rnd * float(length(grid)))
    let pos = grid[cell]
    if (length(pos) > 0.0)
      let idx = floori(rnd * float(length(skyTexKeys)))
      spawn_nebula(pos, get_image(skyTexKeys[idx]))
      grid[cell] = float2()
      i++
  
