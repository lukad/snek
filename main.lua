require "player"

GRID_SIZE = 16
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
keys = {}

p = Player.new()

function love.load()
	love.graphics.setBackgroundColor(253, 246, 227)
end

function drawGrid()
	love.graphics.setColor(238, 232, 213, 255);
	for x=GRID_SIZE, WIDTH, GRID_SIZE do
		love.graphics.line(x, 0, x, HEIGHT)
	end
	for y=GRID_SIZE, HEIGHT, GRID_SIZE do
		love.graphics.line(0, y, WIDTH, y)
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
	keys[key] = true
	if key == "left" and p.direction ~= "right" then p.direction = key end
	if key == "right" and p.direction ~= "left" then p.direction = key end
	if key == "up" and p.direction ~= "down" then p.direction = key end
	if key == "down" and p.direction ~= "up" then p.direction = key end
end

function love.keyreleased(key)
	keys[key] = false
end
