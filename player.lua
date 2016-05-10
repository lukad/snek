local class = require 'lib.middleclass'

local Player = class('Player')

function Player:initialize()
  self.x = 0
  self.y = 1
  self.points = {{self.x, self.y}, {self.x, self.y}, {self.x, self.y}}
  self.speed = 10
  self.direction = "right"
end

function Player:draw(r, g, b)
  love.graphics.setColor(r, g, b)
  for _, p in ipairs(self.points) do
    local x = math.floor(p[1])
    local y = math.floor(p[2])
    love.graphics.rectangle("fill", x * GRID_SIZE, y * GRID_SIZE, GRID_SIZE, GRID_SIZE)
  end
end

function Player:keypressed(key, _isrepeat)
  if key == "left" and self.direction ~= "right" then self.direction = key end
  if key == "right" and self.direction ~= "left" then self.direction = key end
  if key == "up" and self.direction ~= "down" then self.direction = key end
  if key == "down" and self.direction ~= "up" then self.direction = key end
end

function Player:update(dt)
  if self.direction == "right" then self.x = self.x + self.speed * dt end
  if self.direction == "left" then self.x = self.x - self.speed * dt end
  if self.direction == "up" then self.y = self.y - self.speed * dt end
  if self.direction == "down" then self.y = self.y + self.speed * dt end

  if math.floor(self.x) == self.points[1][1] and math.floor(self.y) == self.points[1][2] then return end

  if self.x >= WIDTH / GRID_SIZE then self.x = 0 + self.x % (WIDTH / GRID_SIZE) end
  if self.x < 0 then self.x = WIDTH / GRID_SIZE - self.x end
  if self.y >= HEIGHT / GRID_SIZE then self.y = 0 + self.y % (HEIGHT / GRID_SIZE) end
  if self.y < 0 then self.y = HEIGHT / GRID_SIZE - self.y end

  for i = #self.points, 2, -1 do
    self.points[i][1] = math.floor(self.points[i-1][1])
    self.points[i][2] = math.floor(self.points[i-1][2])
  end

  self.points[1][1] = math.floor(self.x)
  self.points[1][2] = math.floor(self.y)
end

-- Appends n items to the player
function Player:grow(n)
  point = self.points[#self.points]
  for i = 1, n, 1 do
    table.insert(self.points, {point[1], point[2]})
  end
end

return Player
