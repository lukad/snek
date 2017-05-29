local Player = require "player"
local Candy = require "candy"
local Timer = require "lib/hump/timer"
local util = require "util"

local Game = {}

function Game:init()
  self.score_font = love.graphics.newFont("assets/FFFFORWA.TTF", 150)
  self.timer = Timer.new()
end

function Game:enter()
  self.keys = {}
  self.p = Player:new()
  self.candys = {}
  self:add_candy()
  self.score = 0
  self.timer.clear()
end

function Game:my_draw()
  for _, candy in ipairs(Game.candys) do
    candy:draw()
  end
  self:draw_score()
  self.p:draw(255, 255, 255)
  util.draw_grid()
end

function Game:draw_score()
  love.graphics.setColor(255, 255, 255, 50)
  love.graphics.setFont(self.score_font)
  love.graphics.printf(
    math.floor(self.score),
    WIDTH/2 - 800/2,
    HEIGHT/2 - self.score_font:getHeight()/3,
    800,
    "center"
  )
end

function Game:update(dt)
  self.timer.update(dt)
  self:check_collisions()
  self.p:update(dt)
end

function Game:keypressed(key, isrepeat)
  self.p:keypressed(key, isrepeat)
end

function Game:add_candy()
  local x = 1 + love.math.random(WIDTH_GRID - 3)
  local y = 1 + love.math.random(HEIGHT_GRID - 3)
  local candy = Candy:new({x, y}, 1)
  table.insert(self.candys, candy)
end

function Game:check_collisions()
  if not self.p.alive then return end

  for i, candy in ipairs(self.candys) do
    if self.p.points[1][1] == candy.x and self.p.points[1][2] == candy.y then
      self:eat_candy(candy)
      table.remove(self.candys, i)
      self:add_candy()
    end
  end

  if self.p:collides_with_self() then
    self.p:die()
  end
end

function Game:eat_candy(candy)
  self.p:grow(candy.worth)
  self.timer.tween(0.1, self, {score = self.score + candy.worth * 10})
end

return Game
