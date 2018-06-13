Tile = Object:extend()


function Tile:new( name, moveCost, defBonus )
	self.image = love.graphics.newImage( "/resources/tiles/"..name )
	self.name = name
	self.moveCost = moveCost
	self.defBonus = defBonus
end

function Tile:draw( x, y )
	printByTile(self.image, x, y)
end

