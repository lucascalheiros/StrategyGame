require "map"

function love.load()
	windowSize = {
		x = 800,
		y = 500
	}
    love.window.setMode( windowSize.x, windowSize.y)
    love.window.setTitle( "Jogo estrategia" )
	selPos = {
		x = 400,
		y = 250
	}
	tamX = 50
	tamY = 50
	map = createRandomTileMap(tamX, tamY, 1)
	love.keyboard.setKeyRepeat(true)

end

function love.update(dt)
	if love.keyboard.isDown("up") then
		selPos.y = selPos.y - 10
	elseif love.keyboard.isDown("down") then
		selPos.y = selPos.y + 10
	elseif love.keyboard.isDown("right") then
		selPos.x = selPos.x + 10
	elseif love.keyboard.isDown("left") then
		selPos.x = selPos.x - 10
	end
 	if selPos.y > windowSize.y then
		selPos.y = windowSize.y
		cameraMove(tamX, tamY, "down")
	elseif selPos.y < 0 then
		selPos.y = 0
		cameraMove(tamX, tamY, "up")
	elseif selPos.x > windowSize.x then
		selPos.x = windowSize.x
		cameraMove(tamX, tamY, "right")
	elseif selPos.x < 0 then
		selPos.x = 0
		cameraMove(tamX, tamY, "left")
	end
	
		
	
end

function love.draw()
	
	printMap(map)
	love.graphics.setColor(0, 255, 0)
	love.graphics.circle("fill", selPos.x, selPos.y, 20)
	love.graphics.setColor(255, 255, 255)


end



