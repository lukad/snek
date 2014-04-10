require "player"

GRID_SIZE = 16

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255)
end

function drawGrid()
	love.graphics.setColor(238, 238, 238, 255);
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	for x=GRID_SIZE, w, GRID_SIZE do
		love.graphics.line(x, 0, x, h)
	end
	for y=GRID_SIZE, h, GRID_SIZE do
		love.graphics.line(0, y, w, y)
	end
end

function love.draw()
	drawGrid()
end

function love.update(dt)
end

function love.keypressed(key, isrepeat)
end

function love.keyreleased(key)
end
