local Gamestate = require('lib/hump/gamestate')
local Game = require('game')

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(Game)
end
