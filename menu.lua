local Gamestate = require('lib/hump/gamestate')
local Game = require('game')
local util = require('util')
local menu = {}

function menu:init()
  menu.logo_font = love.graphics.newFont("assets/FFFFORWA.TTF", 100)
  menu.go_font = love.graphics.newFont("assets/FFFFORWA.TTF", 20)
end

function menu:keypressed(key, _isrepeat)
  if key == "space" then
    Gamestate.switch(Game)
  end
end

function menu:my_draw()
  util.draw_grid()

  love.graphics.setColor(255, 255, 255, 150)
  love.graphics.setFont(menu.logo_font)
  love.graphics.printf(
    "SNEK",
    WIDTH/2 - 400/2,
    HEIGHT/2 - menu.logo_font:getHeight()/2,
    400,
    "center"
  )

  love.graphics.setFont(menu.go_font)
  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.printf(
    "press space to play",
    WIDTH/2 - 400/2,
    HEIGHT/3*2 - menu.go_font:getHeight()/2,
    400,
    "center"
  )
end

return menu
