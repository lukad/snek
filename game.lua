local Player = require "player"
local Candy = require "candy"

local Game = {}

GRID_SIZE = 16
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
WIDTH_GRID = WIDTH / GRID_SIZE
HEIGHT_GRID = HEIGHT / GRID_SIZE


function Game:enter()
  love.graphics.setBackgroundColor(253, 246, 227)
  Game.keys = {}
  Game.candys = {Candy:new({5,5})}
  Game.p = Player:new()
end

function Game:draw_grid()
  love.graphics.setColor(238, 232, 213, 255);
  for x = GRID_SIZE, WIDTH, GRID_SIZE do
    love.graphics.line(x, 0, x, HEIGHT)
  end
  for y = GRID_SIZE, HEIGHT, GRID_SIZE do
    love.graphics.line(0, y, WIDTH, y)
  end
end

function Game:draw_score()
  love.graphics.setColor(220, 50, 47)
  love.graphics.print("Score: " .. (Game.p:length() - 5) * 100, 0, 0)
end

function Game:draw()
 for _, candy in ipairs(Game.candys) do
   candy:draw()
 end
 Game.p:draw(38, 139, 210)
 Game:draw_grid()
 Game:draw_score()
end

function Game:update(dt)
  Game:check_collisions()
  Game.p:update(dt)
end

function Game:keypressed(key, isrepeat)
  Game.p:keypressed(key, isrepeat)
end

function Game:check_collisions()
  if not Game.p.alive then return end

  for i, candy in ipairs(Game.candys) do
    if Game.p.points[1][1] == candy.x and Game.p.points[1][2] == candy.y then
      table.remove(Game.candys, i)
      local x = math.random(WIDTH_GRID) - 1
      local y = math.random(HEIGHT_GRID) - 1
      table.insert(Game.candys, Candy:new({x, y}))
      Game.p:grow(candy.worth)
    end
  end

  if Game.p:collides_with_self() then
    Game.p:die()
  end
end

return Game
