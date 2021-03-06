require "tile"
Map = GameObject:extend()

function Map:new()
	self.super.new(self)

	tile = {}
	tile[1] = Tile( "black.png", 99, 1 )
	tile[2] = Tile( "white.png", 1, 1 )
	tile[3] = Tile( "gray.png", 1, 1 )
end

--#TODO criar mapa de verdade
function Map:createRandomTileMap(tamX, tamY, nRangeTile)
	self.map = {}
	self.tamX = tamX
	self.tamY = tamY
	for i = 1,self.tamX do
		self.map[i] = {}
		for j = 1,self.tamY do
			self.map[i][j] = tile[love.math.random(2,3)]
			if(i == tamX or j == tamY or i == 1 or j == 1) then
				self.map[i][j] = tile[1]
			end
		end
	end
end

function Map:centerCam(x,y)
	camera.x = x + math.floor(-rangeWindow.x/2) --8
	camera.y = y + math.floor(-rangeWindow.y/2) --5
	if camera.x < 1 then camera.x = 1 end
	if camera.y < 1 then camera.y = 1 end
	if camera.x >= self.tamX - rangeWindow.x then camera.x = self.tamX - rangeWindow.x + 1 end
	if camera.y >= self.tamY - rangeWindow.y then camera.y = self.tamY - rangeWindow.y + 1 end
	if self.tamX > x and self.tamY > y and x > 1 and y > 1 then -- se dentro das especificações do mapa seleciona a posição
		selPos.x = x - camera.x
		selPos.y = y - camera.y
	end
end

function Map:cameraMove( position )
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
		camera.x = self.tamX - rangeWindow.x + 1
	end
	if camera.x < 1 then
		camera.x = 1
	end
	if camera.y + rangeWindow.y > self.tamY then
		camera.y = self.tamY - rangeWindow.y + 1
	end
	if camera.y < 1 then
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

function Map:cameraPosition()
	if selPos.y >= rangeWindow.y - 1 then
		selPos.y = selPos.y - 1
		map:cameraMove("down")
	end
	if selPos.y < 1 then
		selPos.y = selPos.y + 1
		map:cameraMove("up")
	end
	if selPos.x >= rangeWindow.x -1 then
		selPos.x = selPos.x - 1
		map:cameraMove("right")
	end
	if selPos.x < 1 then
		selPos.x = selPos.x + 1
		map:cameraMove("left")
	end
end

function Map:mouseSlide(x,y)
	x, y = input.mouse.x, input.mouse.y
	x1, y1 = love.mouse.getPosition( )
	if x1 +75< x then
		map:cameraMove("right")
	elseif x1 -75> x then
		map:cameraMove("left")
	end
	if y1 -75 > y then
		map:cameraMove("up")
	elseif y1 +75< y then
		map:cameraMove("down")
	end
	x1,y1 = x,y
end

function Map:update(dt)
	self.super.update(self, dt)
	input:mouseMap(1,0.17,self.mouseSlide)
	self:cameraPosition()
end

function Map:draw()
	for i = camera.x, rangeWindow.x + camera.x - 1 do
		for j = camera.y , rangeWindow.y + camera.y - 1 do
			self.map[i][j]:draw( i - camera.x, j - camera.y )
		end
	end
end
