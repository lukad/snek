require "player"
require "candy"

GRID_SIZE = 16
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
WIDTH_GRID = WIDTH / GRID_SIZE
HEIGHT_GRID = HEIGHT / GRID_SIZE
keys = {}
candys = {Candy.new({5,5})}

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
	for _, candy in ipairs(candys) do
		Candy.draw(candy)
	end
	Player.draw(p, 38, 139, 210)
	drawGrid()
end

function love.update(dt)
	Player.update(p, dt)
	checkCollisions()
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

function checkCollisions()
	for i, candy in ipairs(candys) do
		if p.points[1][1] == candy.x and p.points[1][2] == candy.y then
			table.remove(candys, i)
			local x = math.random(WIDTH_GRID)-1
			local y = math.random(HEIGHT_GRID)-1
			table.insert(candys, Candy.new({x, y}))
			Player.grow(p, candy.worth)
			return true
		end
	end
end
