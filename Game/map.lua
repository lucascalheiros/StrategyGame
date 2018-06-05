Map = {}
Map.__index = Map

function Map:new()
	self.size = {
	x = 800,
	y = 500
	}
--	Representa o numero da tile de posição superior esquerda da camera
	self.camera = {
	x = 1,
	y = 1
	}
--	Número de tiles que compõe a tela do jogo
	self.tilesWindow = {
	x = 16,
	y = 10
	}
	return setmetatable(self,Map)
end

--#TODO criar mapa de verdade
function Map:createRandomTileMap(tamX, tamY, nRangeTile)
	self.map = {}
	self.tamX = tamX +1
	self.tamY = tamY +1
	math.randomseed(os.time())
	for i = 1,self.tamY do
		self.map[i] = {}
		for j = 1,self.tamX do
			self.map[i][j] = math.random(0,nRangeTile)
			if(i >= tamY or j >= tamX or i == 1 or j == 1) then
				self.map[i][j] = 3
			end
		end
	end
end


function Map:setCamPos(tileX,tileY) 
	if tileX <= self.size.x and tileX >= 1 and tileY <= self.size.y and tileY >= 1 then
		self.camera.x = tileX - (self.tilesWindow.x - self.tilesWindow.x % 2)/2
		self.camera.y = tileY - (self.tilesWindow.x - self.tilesWindow.y % 2)/2
		if self.camera.x < 1 then self.camera.x = 1 end
		if self.camera.y < 1 then self.camera.y = 1 end
--	#TODO fazer pra limitar posição abaixo
	end
end

function Map:cameraPosition(selPos) 
 	if selPos.y + tileSize > map.size.y then
 		up()
		self:cameraMove("down")
	elseif selPos.y - tileSize < 0 then
		down()
		self:cameraMove("up")
	elseif selPos.x + tileSize > map.size.x then
		left()
		self:cameraMove("right")
	elseif selPos.x - tileSize < 0 then
		right()
		self:cameraMove("left")
	end
end

function Map:cameraMove( position)
	if position == "up" then
		self.camera.y = self.camera.y - 1
	elseif position == "down" then
		self.camera.y = self.camera.y + 1
	elseif position == "left" then
		self.camera.x = self.camera.x - 1
	elseif position == "right" then
		self.camera.x = self.camera.x + 1
	end
	if self.camera.x + self.tilesWindow.x > self.tamX then
		self.camera.x = self.tamX - self.tilesWindow.x
	elseif self.camera.x < 1 then
		self.camera.x = 1
	elseif self.camera.y + self.tilesWindow.y > self.tamY then
		self.camera.y = self.tamY - self.tilesWindow.y
	elseif self.camera.y < 1 then
		self.camera.y = 1
	end
end


function Map:getActualTile(x,y)
	actualTile = {
	x = (x - x%50)/50 + self.camera.x,
	y = (y - y%50)/50 + self.camera.y
	}
	return actualTile
end

--	em razão de testes
function Map:getActualCamera(x,y)

	return self.camera
end
	
function Map:print()
	white = love.graphics.newImage( "white.png" )
	black = love.graphics.newImage( "black.png" )

    for i = self.camera.y, self.camera.y + self.tilesWindow.y do
        for j = self.camera.x , self.camera.x + self.tilesWindow.x do
            if self.map[i][j] == 0 then
                love.graphics.draw(black, (j-self.camera.x)*tileSize, (i-self.camera.y)*tileSize)
            elseif self.map[i][j] == 1 then 
                love.graphics.draw(white, (j-self.camera.x)*tileSize, (i-self.camera.y)*tileSize)
            end
        end
    end
end
