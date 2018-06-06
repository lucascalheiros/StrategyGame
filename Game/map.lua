Map = Object:extend()

function Map:new()
end

--#TODO criar mapa de verdade
function Map:createRandomTileMap(tamX, tamY, nRangeTile)
	self.map = {}
	self.tamX = tamX +1
	self.tamY = tamY +1
	for i = 1,self.tamY do
		self.map[i] = {}
		for j = 1,self.tamX do
			self.map[i][j] = love.math.random(0,nRangeTile)
			if(i >= tamY or j >= tamX or i == 1 or j == 1) then
				self.map[i][j] = 3
			end
		end
	end
end

--	#TODO centralizar camera
function Map:setCamPos(tileX,tileY) 
	camera.x = tileX - (rangeWindow.x - rangeWindow.x % 2)/2
	camera.y = tileY - (rangeWindow.y - rangeWindow.y % 2)/2
	if camera.x < 1 then camera.x = 1 end
	if camera.y < 1 then camera.y = 1 end
	if camera.x >= self.tamX - rangeWindow.x then camera.x = self.tamX - rangeWindow.x end
	if camera.y >= self.tamY - rangeWindow.y then camera.y = self.tamY - rangeWindow.y end
end



function Map:cameraMove( position)
	if position == "up" then
		camera.y = camera.y - 1
	elseif position == "down" then
		camera.y = camera.y + 1
	elseif position == "left" then
		camera.x = camera.x - 1
	elseif position == "right" then
		camera.x = camera.x + 1
	end
	if camera.x + rangeWindow.x > self.tamX then
		camera.x = self.tamX - rangeWindow.x
	elseif camera.x < 1 then
		camera.x = 1
	elseif camera.y + rangeWindow.y > self.tamY then
		camera.y = self.tamY - rangeWindow.y
	elseif camera.y < 1 then
		camera.y = 1
	end
end

function Map:getActualTile(x,y)
	actualTile = {
	x = x + camera.x,
	y = y + camera.y
	}
	return actualTile
end

function Map:cameraPosition(x,y) 
	if y >= rangeWindow.y then
		up()
		map:cameraMove("down")
	elseif y < 0 then
		down()
		map:cameraMove("up")
	elseif x >= rangeWindow.x then
		left()
		map:cameraMove("right")
	elseif x < 0 then
		right()
		map:cameraMove("left")
	end
end

function Map:update()
	self:cameraPosition(selPos.x, selPos.y)
end

function Map:draw()
	white = love.graphics.newImage( "white.png" )
	black = love.graphics.newImage( "black.png" )

    for i = camera.y, camera.y + rangeWindow.y do
        for j = camera.x , camera.x + rangeWindow.x do
            if self.map[j][i] == 0 then
            	printByTile(black, j-camera.x, i-camera.y)
            elseif self.map[j][i] == 1 then 
            	printByTile(white, j-camera.x, i-camera.y)
            end
        end
    end
end
