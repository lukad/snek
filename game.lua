local Player = require "player"
local Candy = require "candy"
local util = require "util"

local Game = {}

function Game:enter()
  Game.keys = {}
  Game.p = Player:new()
  Game.candys = {}
  Game:add_candy()
end

function Game:my_draw()
  for _, candy in ipairs(Game.candys) do
    candy:draw()
  end
  -- self:draw_score()
  self.p:draw(255, 255, 255)
  util.draw_grid()
end

function Game:update(dt)
  self:check_collisions()
  Game.p:update(dt)
end

function Game:keypressed(key, isrepeat)
  self.p:keypressed(key, isrepeat)
end

function Game:add_candy()
  local x = 1 + love.math.random(WIDTH_GRID - 3)
  local y = 1 + love.math.random(HEIGHT_GRID - 3)
  table.insert(self.candys, Candy:new({x, y}))
end

function Game:check_collisions()
  if not self.p.alive then return end

  for i, candy in ipairs(Game.candys) do
    if self.p.points[1][1] == candy.x and self.p.points[1][2] == candy.y then
      table.remove(Game.candys, i)
      self.p:grow(candy.worth)
      self:add_candy()
    end
  end

  if self.p:collides_with_self() then
    self.p:die()
  end
end

return Game
