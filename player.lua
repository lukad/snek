Player = {}
function Player.new()
	return {
		x = 0,
		y = 1,
		points = {{5, 1}, {4, 6}, {0, 3}},
		speed = 10,
		direction = "right"
	}
end

function Player.draw(player, r, g, b)
	love.graphics.setColor(r, g, b)
	for _, p in ipairs(player.points) do
		local x = math.floor(p[1])
		local y = math.floor(p[2])
		love.graphics.rectangle("fill", x * GRID_SIZE, y * GRID_SIZE, GRID_SIZE, GRID_SIZE)
	end
end

function Player.update(player, dt)
	if player.direction == "right" then player.x = player.x + player.speed * dt end
	if player.direction == "left" then player.x = player.x - player.speed * dt end
	if player.direction == "up" then player.y = player.y - player.speed * dt end
	if player.direction == "down" then player.y = player.y + player.speed * dt end

	if math.floor(player.x) == player.points[1][1] and math.floor(player.y) == player.points[1][2] then return end

	if player.x >= WIDTH / GRID_SIZE then player.x = 0 + player.x % (WIDTH / GRID_SIZE) end
	if player.x < 0 then player.x = WIDTH / GRID_SIZE - player.x end
	if player.y >= HEIGHT / GRID_SIZE then player.y = 0 + player.y % (HEIGHT / GRID_SIZE) end
	if player.y < 0 then player.y = HEIGHT / GRID_SIZE - player.y end

	for i = #player.points, 2, -1 do
		player.points[i][1] = math.floor(player.points[i-1][1])
		player.points[i][2] = math.floor(player.points[i-1][2])
	end

	player.points[1][1] = math.floor(player.x)
	player.points[1][2] = math.floor(player.y)
end
