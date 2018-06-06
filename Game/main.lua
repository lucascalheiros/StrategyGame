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
	x = 0,
	y = 0
}

function love.load()
--	superior esquerda(0,0)
--	inferior direita(15,9)
	selPos = {
		x = 1,
		y = 8
	}

--	Tamanho do mapa em tiles
	tamX = 20
	tamY = 20
	map = Map()
	map:createRandomTileMap(tamX, tamY, 1)
	mec = Mec(map)
	input = Input()
	delayClick = 0.17

--	se colocados valores fora do mapa será selecionada a area mais próxima
	map:setCamPos(0,50)
	selection = love.graphics.newImage( "selection.png" )
	x=0
	y=0
	lastClick = 0
end

function love.update(dt)
	input:update()
	map:update()
	
	
	actualTile = map:getActualTile(selPos.x, selPos.y)

end

function love.draw()

	map:draw()
	mec:draw()
	
	
	
	printByTile(selection, selPos.x, selPos.y)
	love.graphics.setColor(255, 0, 0)
	love.graphics.print("Tile "..actualTile.x.." "..actualTile.y, 12, 26)
	love.graphics.print("Camera "..camera.x.." "..camera.y, 12, 40)
		love.graphics.print("Mouse "..x.." "..y, 12, 54)
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

function setSelPos(x,y)
	selPos.x = x
	selPos.y = y
end

function printByTile(image, x, y)
	posX = x*50
	posY = y*50
	love.graphics.draw(image, posX, posY)
end






