local class = require 'lib.middleclass'

local Player = class('Player')

Player.static.powerup_sound = love.audio.newSource('assets/powerup.wav', 'static')
Player.static.explosion_sound = love.audio.newSource('assets/explosion.wav', 'static')

function Player:initialize()
  self.alive = true
  self.x = 0
  self.y = 1
  self.points = {{self.x, self.y}, {self.x - 1, self.y}, {self.x -2, self.y}, {self.x - 3, self.y}, {self.x - 4, self.y}}
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

function Player:length()
  return #self.points
end

function Player:keypressed(key, _isrepeat)
  if key == "left" and self.last_direction ~= "right" then self.direction = key end
  if key == "right" and self.last_direction ~= "left" then self.direction = key end
  if key == "up" and self.last_direction ~= "down" then self.direction = key end
  if key == "down" and self.last_direction ~= "up" then self.direction = key end
end

function Player:update(dt)
  if not self.alive then return end

  if self.direction == "right" then self.x = self.x + self.speed * dt end
  if self.direction == "left" then self.x = self.x - self.speed * dt end
  if self.direction == "up" then self.y = self.y - self.speed * dt end
  if self.direction == "down" then self.y = self.y + self.speed * dt end

  if math.floor(self.x) == self.points[1][1] and math.floor(self.y) == self.points[1][2] then return end

  self.last_direction = self.direction

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

function Player:collides_with_self()
  for i = #self.points, 2, -1 do
    if self.points[i][1] == self.points[1][1] and
      self.points[i][2] == self.points[1][2]
    then
      return true
    end
  end
end

function Player:die()
  love.audio.play(Player.static.explosion_sound)
  self.alive = false
end

function Player:grow(n)
  love.audio.play(Player.static.powerup_sound)
  point = self.points[#self.points]
  for i = 1, n, 1 do
    table.insert(self.points, {point[1], point[2]})
  end
end

return Player
