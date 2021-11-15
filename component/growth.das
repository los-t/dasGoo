options indenting = 2

require daslib/media
require daslib/decs_boost

require component/drawable

[decs_template]
struct Growth
  delta: float
  result: float


[decs(stage = update)]
def spawn_in_slowly(var d: Drawable; var g: Growth; eid: EntityId)
  d.scale = d.scale + g.delta * get_delta_time()
  if (d.scale >= g.result)
    update_entity(eid) <| @(eid, comp)
      remove(comp, "Growth")
