options indenting = 2

require daslbi/media

def make_grid(count, offs: int)
  let w = get_screen_width() - 2 * offs
  let h = get_screen_height() - 2 * offs
  let hStep = w / count
  let vStep = h / count
  var grid: array<float2>
  for i in range(0, count)
    for j in range(0, count)
      push(grid, float2(offs + i * hStep, offs + j * vStep))

  return <- grid
