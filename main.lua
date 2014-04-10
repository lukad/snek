require "player"

GRID_SIZE = 16

p = Player.new()

function love.load()
	love.graphics.setBackgroundColor(253, 246, 227)
end

function drawGrid()
	love.graphics.setColor(238, 232, 213, 255);
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
	-- Player.draw(p, 147, 161, 161)
	Player.draw(p, 38, 139, 210)
	drawGrid()
end

function love.update(dt)
	Player.update(p, dt)
end

function love.keypressed(key, isrepeat)
end

function love.keyreleased(key)
end
