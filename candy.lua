local class = require 'lib.middleclass'

local Candy = class('Candy')

function Candy:initialize(pos, worth)
  self.x = pos[1]
  self.y = pos[2]
  self.worth = worth
end

function Candy:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x * GRID_SIZE + 1, self.y * GRID_SIZE + 1, GRID_SIZE - 1, GRID_SIZE - 1)
end

return Candy
