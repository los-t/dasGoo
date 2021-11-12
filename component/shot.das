options indenting = 2

require daslib/decs_boost

[decs_template]
struct Shot
  damage: float


[decs(stage = update)]
def delete_used_shots(s: Shot; eid: EntityId)
  if (s.damage <= 0.0)
    delete_entity(eid)
