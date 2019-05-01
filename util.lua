local util = {}

function util.draw_grid()
  love.graphics.setColor(1, 1, 1, 1/5);
  for x = GRID_SIZE, WIDTH, GRID_SIZE do
    love.graphics.line(x, 0, x, HEIGHT)
  end
  for y = GRID_SIZE, HEIGHT, GRID_SIZE do
    love.graphics.line(0, y, WIDTH, y)
  end
end

return util
