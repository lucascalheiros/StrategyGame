Mob = {}
Mob.__index = Mob


--#TODO
function Mob:new( isPlayer)
	local mob = {}
	mob = setmetatable(mob, Mob)
	mob.maxLife = 100
	mob.life = 100
	mob.maxMove = 5
	mob.move = 5
	mob.atk = 30
	mob.isPlayer = isPlayer --valor booleano
	mob.image = love.graphics.newImage( "mob.png" )
	return mob
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
