Mob = {}
Mob.__index = Mob


--#TODO
function Mob:new( iSplayer, x0, y0)
	self.life = 100
	self.atk = 10
	self.iSplayer = iSplayer --valor booleano
	self.pos = {
		x = x0
		y = y0
	}
end



--#TODO
function Mob:print()
	color = self.life*255/100
	if iSplayer then 
		love.graphics.setColor(0, 0, color)
	else
		love.graphics.setColor(color, 0, 0)
	end
	love.graphics.circle("fill", self.pos.x, self.pos.y, 20)
	love.graphics.setColor(255, 255, 255)
end
