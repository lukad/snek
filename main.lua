local Gamestate = require('lib/hump/gamestate')
local Menu = require('menu')

GRID_SIZE = 16
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
WIDTH_GRID = WIDTH / GRID_SIZE
HEIGHT_GRID = HEIGHT / GRID_SIZE

shader = {}
effects = {}
canvas = {}
mesh = {}
font = {}

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  if key == '1' then toggle_effect("chromatic_aberation") end
  if key == '2' then toggle_effect("vignette") end
  if key == '3' then toggle_effect("tint") end
  if key == '4' then toggle_effect("scanlines") end
  if key == '5' then toggle_effect("flickering") end
end

function toggle_effect(effect)
  state = effects[effect]
  if state == nil then
    state = false
  else
    state = not state
  end
  effects[effect] = state
  shader:send(effect .. "_enabled", state)
end

function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.setShader()
  love.graphics.clear()
  love.graphics.setBlendMode("alpha")
  Gamestate.current():my_draw()


  love.graphics.setCanvas()
  love.graphics.setShader(shader)
  shader:send("time", love.timer.getTime())
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(canvas, 0, 0)
end

function love.load()
  canvas = love.graphics.newCanvas()

  shader_source = love.filesystem.read("shader.glsl")
  shader = love.graphics.newShader(shader_source)

  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end
