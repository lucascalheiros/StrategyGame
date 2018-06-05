require "map"
require "input"

function love.load()
	selPos = {
		x = 75,
		y = 425
	}
	actualTile = {}
	camera ={}
--	Tamanho do mapa em tiles
	tamX = 50
	tamY = 50
	map = Map:new()
	map:createRandomTileMap(tamX, tamY, 1)
	input = Input:new()
	delayClick = 0.17
	map:setCamPos(2,49)
end

function love.update(dt)

	input:downUp(delayClick,up)
	input:downDn(delayClick,down)
	input:downLt(delayClick,left)
	input:downRt(delayClick,right)
	map:cameraPosition(selPos)

	actualTile = map:getActualTile(selPos.x, selPos.y)
	camera = map:getActualCamera(selPos.x, selPos.y)

end

function love.draw()

	map:print()
	love.graphics.setColor(0, 255, 0)
	love.graphics.circle("fill", selPos.x, selPos.y, 20)
	love.graphics.setColor(255, 0, 0)
	love.graphics.print("Tile "..actualTile.x.." "..actualTile.y, 12, 26)
	love.graphics.print("Camera "..camera.x.." "..camera.y, 12, 40)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 0, 500, 800, 150 )
end

function up() selPos.y = selPos.y - tileSize end
function down() selPos.y = selPos.y + tileSize end
function left() selPos.x = selPos.x - tileSize end
function right() selPos.x = selPos.x + tileSize end

