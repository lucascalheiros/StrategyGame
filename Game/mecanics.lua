require "mob"

Mec = Object:extend()

--#TODO
function Mec:new(map) 
	tamX = map.tamX
	tamY = map.tamY
	self.mobs = {} -- lista de mobs
	mobsCounter = 0
	for i = 1, tamY do
		for j = 1, tamX do
			chance = love.math.random(0,20)
			if chance > 19 then
				mobsCounter = mobsCounter + 1
				self.mobs[mobsCounter] =  Mob(true,i,j)
			elseif chance < 1 then
				mobsCounter = mobsCounter + 1
				self.mobs[mobsCounter] =  Mob(false,i,j)
			end
		end
	end
	self.turn = 0
end

function Mec:turn()
	if sell.turn % 2 == 0 then 

	else

	end
end



function Mec:update()
	
end

function Mec:info()
	for _, mob in ipairs(self.mobs) do
		if mob.pos.x == actualTile.x and mob.pos.y == actualTile.y then
			love.graphics.setColor(255, 0, 0)
			if mob.isPlayer then
				love.graphics.print("Player", 12, 526)
			else
				love.graphics.print("Enemy", 12, 526)
			end
			love.graphics.setColor(255, 255, 255)
		end
	end
end

function Mec:draw()
    for _, mob in ipairs(self.mobs) do
    	mob:draw(mob.pos.x - camera.x, mob.pos.y - camera.y )
    end
end





