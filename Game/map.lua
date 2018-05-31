function createRandomTileMap(tamX, tamY, nRangeTile)
	map = {}
	math.randomseed(os.time())
	for i = 1,tamY do
		map[i] = {}
		for j = 1,tamX do
			map[i][j] = math.random(0,nRangeTile)
		end
	end

	return map
end

function cameraMove(tamX, tamY, position)
	
	if position == "up" then
		camera.y = camera.y - 1
	elseif position == "down" then
		camera.y = camera.y + 1
	elseif position == "left" then
		camera.x = camera.x - 1
	elseif position == "right" then
		camera.x = camera.x + 1
	end
	if camera.x + 16 > tamX then
		camera.x = tamX - 16
	elseif camera.x < 1 then
		camera.x = 1
	elseif camera.y + 10 > tamY then
		camera.y = tamY - 10
	elseif camera.y < 1 then
		camera.y = 1
	end

	
	
	
end
camera = {
	x = 1,
	y = 1
}

	
function printMap(map)
	white = love.graphics.newImage( "white.png" )
	black = love.graphics.newImage( "black.png" )
	love.graphics.scale(2.5, 2.5)
	size = 20
    for i = camera.y, camera.y + 10 do
        for j = camera.x , camera.x+16 do
            if ( map[i][j] == 0)
            then
                love.graphics.draw(black, (j-camera.x-1)*size, (i-camera.y-1)*size)
            else
                love.graphics.draw(white, (j-camera.x-1)*size, (i-camera.y-1)*size)
            end
        end
    end
	love.graphics.scale(0.4, 0.4)

end
