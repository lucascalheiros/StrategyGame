Mob = Object:extend()


--#TODO
function Mob:new( isPlayer)
	self.maxLife = 100
	self.life = 100
	self.maxMove = 5
	self.move = 5
	self.atk = 30
	self.isPlayer = isPlayer --valor booleano
	self.image = love.graphics.newImage( "mob.png" )
end

--#TODO
function Mob:print(x,y)
	color = self.life*255/100
	if self.isPlayer then 
		love.graphics.setColor(0, 0, color)
	else
		love.graphics.setColor(color, 0, 0)
	end
	printByTile(self.image,x,y);
	love.graphics.setColor(255, 255, 255)
end
