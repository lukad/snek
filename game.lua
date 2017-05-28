local Player = require "player"
local Candy = require "candy"

local Game = {}

function Game:enter()
  Game.keys = {}
  Game.p = Player:new()
  Game.candys = {}
  Game:add_candy()
end

function Game:draw_grid()
  love.graphics.setColor(255, 255, 255, 50);
  for x = GRID_SIZE, WIDTH, GRID_SIZE do
    love.graphics.line(x, 0, x, HEIGHT)
  end
  for y = GRID_SIZE, HEIGHT, GRID_SIZE do
    love.graphics.line(0, y, WIDTH, y)
  end
end

function Game:my_draw()
  for _, candy in ipairs(Game.candys) do
    candy:draw()
  end
  Game.p:draw(255, 255, 255)
  Game:draw_grid()
end

function Game:update(dt)
  Game:check_collisions()
  Game.p:update(dt)
end

function Game:keypressed(key, isrepeat)
  Game.p:keypressed(key, isrepeat)
end

function Game:add_candy()
  local x = love.math.random(WIDTH_GRID) - 1
  local y = love.math.random(HEIGHT_GRID) - 1
  table.insert(Game.candys, Candy:new({x, y}))
end

function Game:check_collisions()
  if not Game.p.alive then return end

  for i, candy in ipairs(Game.candys) do
    if Game.p.points[1][1] == candy.x and Game.p.points[1][2] == candy.y then
      table.remove(Game.candys, i)
      Game.p:grow(candy.worth)
      Game:add_candy()
    end
  end

  if Game.p:collides_with_self() then
    Game.p:die()
  end
end

return Game
