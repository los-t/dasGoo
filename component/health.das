options indenting = 2

require daslib/decs_boost

[decs_template]
struct Health
  hp: float


[decs(stage = update)]
def delete_dead(h: Health; eid: EntityId)
  if (h.hp <= 0.0)
    delete_entity(eid)
