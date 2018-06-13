Object = require "libs/classic"
GameObject = require "objects/GameObject"
Timer = require "libs/EnhancedTimer"
GameLoop = require "gameLoop"
require "map"
require "input"
require "mecanics"

--	Posição superior esquerda da camera do jogo
camera = {
	x = 1,
	y = 1
}
--	Número de tiles que compõe a tela do jogo
rangeWindow = {
	x = 16,
	y = 10
}
--	Posição atual do mapa gerada de acordo com a posição da camera e a posição atual da seleção
actualTile = {
	x = 1,
	y = 1
}
--	superior esquerda(0,0)
--	inferior direita(15,9)
selPos = {
	x = 0,
	y = 0
}
function love.load()

--	Tamanho do mapa em tiles
	tamX = 30
	tamY = 30
	map = Map()
	map:createRandomTileMap(tamX, tamY, 1)
	mec = Mec(map)
	input = Input()
	delayClick = 0.17

--	posição inferior esquerda
	map:centerCam(2,tamY - 1)
	selection = love.graphics.newImage( "/resources/tiles/selection.png" )
	selectionBlink = 0
	timer = Timer()
end

function love.update(dt)
	selectionBlink = selectionBlink + 1 --TODO arrumar usado em mecanics

	map:update(dt)
	mec:update(dt)
end

function love.draw()

	map:draw()
	mec:draw()

	love.graphics.setColor(255, 0, 0)
	love.graphics.print("Tile "..actualTile.x.." "..actualTile.y, 12, 26)
	love.graphics.print("Camera "..camera.x.." "..camera.y, 12, 40)
--	love.graphics.print("Mouse "..x.." "..y, 12, 54)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 0, 500, 800, 150 )
	mec:info()
end


function up()
	selPos.y = selPos.y - 1
end
function down()
	selPos.y = selPos.y + 1
end
function left()
	selPos.x = selPos.x - 1
end
function right()
	selPos.x = selPos.x + 1
end

function selToMousePos()
	setSelPos(math.floor(input.mouse.x / tileSize),math.floor(input.mouse.y / tileSize))
end


function setSelPos(x,y)
	selPos.x = x
	selPos.y = y
end

function printByTile(image, x, y)
	posX = x*50
	posY = y*50
	love.graphics.draw(image, posX, posY)
end
