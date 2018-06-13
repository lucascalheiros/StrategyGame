Bar =  GameObject:extend()

function Bar:new(x,y)
	self.x = x or 0
	self.y = y or 500
	self.super.new(self,x,y)
end


function Bar:update()
	self.super.update(self, dt)
	self.mob = mec:mobAtPos(actualTile.x, actualTile.y)
	self.tile = map.map[actualTile.x][actualTile.y]
end

function Bar:info()
	mob = self.mob
	tile = self.tile
	if mob then
		if mob.isPlayer then
			love.graphics.setColor(0.5,0.5,1)
		else
			love.graphics.setColor(1,0.5,0.5)
		end
		love.graphics.print(mob.name, 12, 526)
		love.graphics.print("Life: "..mob.life.."/"..mob.maxLife, 12, 540)
		love.graphics.print("Moves: "..mob.moves.."/"..mob.maxMove, 12, 554)
		love.graphics.print("Atk: "..mob.atk, 12, 568)
		love.graphics.print("Def: "..mob.def, 12, 582)
	end
	if tile then
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(tile.name, 112, 526)
		love.graphics.print("MoveCost: "..tile.moveCost, 112, 540)
		love.graphics.print("DefBonus: "..tile.defBonus, 112, 554)

	end
	love.graphics.setColor(1, 1, 1)
end

function Bar:draw()
	love.graphics.setColor(0.36,0.25,0.2)
	love.graphics.rectangle( "fill", self.x, self.y, 800, 150 )
	love.graphics.setColor(1,1,1)
	self:info()
	
end
