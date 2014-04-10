Player = {}
function Player.new()
	return {
		Points = {{0, 1}, {0, 2}, {0, 3}},
		Speed = 5
	}
end

function Player.draw(player, r, g, b)
	love.graphics.setColor(r, g, b)
	for _, p in ipairs(player.Points) do
		local x = math.floor(p[1])
		local y = math.floor(p[2])
		love.graphics.rectangle("fill", x * GRID_SIZE, y * GRID_SIZE, GRID_SIZE, GRID_SIZE)
	end
end

function Player.update(player, dt)
	local i = #player.Points
	-- print(i)
	-- while i > 2 do
		-- print(player.Points[i][1], player.Points[i][2])
		-- player.Points[i][1] = player.Points[i-1][1]
		-- player.Points[i][2] = player.Points[i-1][2]
		-- i = i - 1
	-- end
	player.Points[3][1] = player.Points[2][1]
	player.Points[3][2] = player.Points[2][2]
	player.Points[2][1] = math.floor(player.Points[1][1])
	player.Points[2][2] = math.floor(player.Points[1][2])

	player.Points[1][1] = player.Points[1][1] + player.Speed * dt
end
