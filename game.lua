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
  self.p:draw(1, 1, 1)
  util.draw_grid()
end

function Game:draw_score()
  love.graphics.setColor(1.0, 1.0, 1.0, 1/5)
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
  local empty_cells = {}

  for y = 0, GRID_HEIGHT - 1 do
    for x = 0, GRID_WIDTH - 1 do
      if not self.p:is_on_cell({x, y}) then
        table.insert(empty_cells, {x, y})
      end
    end
  end

  local cell = empty_cells[math.random(#empty_cells)]
  local candy = Candy:new(cell, 1)

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
  self.timer.tween(0.15, self, {score = self.score + candy.worth * 10})
end

return Game
