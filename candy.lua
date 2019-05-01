local class = require 'lib.middleclass'

local Candy = class('Candy')

function Candy:initialize(pos, worth)
  self.x = pos[1]
  self.y = pos[2]
  self.worth = worth
end

function Candy:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x * GRID_SIZE, self.y * GRID_SIZE, GRID_SIZE, GRID_SIZE)
end

return Candy
