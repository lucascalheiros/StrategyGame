Mob = GameObject:extend()


--#TODO
function Mob:new(isPlayer,x0,y0)
	self.super.new(self, x0, y0)

	self.maxLife = 100
	self.life = 100
	self.maxMove = 5
	self.moves = 5
	self.atk = 30
	self.isPlayer = isPlayer
	self.image = love.graphics.newImage( "mob.png" )
	self.isSelected = false
end

function Mob:selection()
	self.isSelected = true
	map:centerCam(self.pos.x, self.pos.y)
end

function Mob:deSelection()
	self.isSelected = false
end

function Mob:drawMoveArea()

end



function Mob:atack(enemy)
	enemy.life = enemy.life - self.atk
end

function Mob:isDead()
	if self.life <= 0 then
		self.life = 0
		self.dead = true
	end
end

function Mob:turnEnd()
	self.move = self.maxMove
	self.turn = false
end

function Mob:newTurn()
	self.turn = true
end

function Mob:move()
	self.pos.x = actualTile.x
	self.pos.y = actualTile.y
end

function Mob:update()
	self.super.update(self, dt)
--	self:move()
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
	if self.isSelected then
		love.graphics.setColor(0, 255, 0)
		printByTile(selection,x,y)
	end
	love.graphics.setColor(255, 255, 255)
end
