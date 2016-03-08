Candy = {}
function Candy.new(pos)
  return {
    x = pos[1],
    y = pos[2],
    worth = 1
  }
end

function Candy.draw(candy)
  love.graphics.setColor(255, 0, 255)
  love.graphics.rectangle("fill", candy.x * GRID_SIZE, candy.y * GRID_SIZE, GRID_SIZE, GRID_SIZE)
end
