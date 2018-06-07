Mob = Object:extend()


--#TODO
function Mob:new( isPlayer,x0,y0)
	self.maxLife = 100
	self.life = 100
	self.maxMove = 5
	self.move = 5
	self.atk = 30
	self.isDead = false
	self.isPlayer = isPlayer --valor booleano
	self.image = love.graphics.newImage( "mob.png" )
	self.pos = {
	x = x0,
	y = y0
	}
end

function Mob:move(moveCost)
	if moveCost > self.move then
		return false
	else
		self.move = self.move - moveCost
		return self.move
	end
end

function Mob:atack(enemy)
	enemy.life = enemy.life - self.atk
end

function Mob:isDead()
	if self.life <= 0 then
		self.life = 0
		self.isDead = true
	end
end

function Mob:turnEnd()
	self.move = self.maxMove
	self.turn = false
end

function Mob:newTurn()
	self.turn = true
end


--#TODO
function Mob:draw(x,y)
	color = self.life*255/100
	if self.isPlayer then 
		love.graphics.setColor(0, 0, color)
	else
		love.graphics.setColor(color, 0, 0)
	end
	printByTile(self.image,x,y);
	love.graphics.setColor(255, 255, 255)
end
