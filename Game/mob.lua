Mob = Object:extend()


--#TODO
function Mob:new( isPlayer,x0,y0)
	self.maxLife = 100
	self.life = 100
	self.maxMove = 5
	self.moves = 5
	self.atk = 30
	self.isDead = false
	self.isPlayer = isPlayer
	self.image = love.graphics.newImage( "/resources/tiles/mob.png" )
	self.pos = {
	x = x0,
	y = y0
	}
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

function Mob:attack(enemy)
	enemy.life = enemy.life - self.atk
	self.moves = 0
end

function Mob:isDead()
	if self.life <= 0 then
		self.life = 0
		self.isDead = true
	end
end


function Mob:action()
	x, y = actualTile.x,  actualTile.y
	if input:down("up",delayClick) then
		y = y - 1
		action = true
	end
	if input:down("down",delayClick) then
		y = y + 1
		action = true
	end
	if input:down("left",delayClick) then
		x = x - 1
		action = true
	end
	if input:down("right",delayClick) then
		x = x + 1
		action = true
	end
	if action then
		mob = mec:mobAtPos(x,y)
		if mob then
			if not(mob.isPlayer) then
				self:attack(mob)
			end
		else
			moveCost = map.map[x][y].moveCost
			remainMoves = self.moves - moveCost
			if remainMoves >= 0 then
				self.moves = remainMoves
				self.pos.x, self.pos.y = x, y
				selPos.x, selPos.y = x - camera.x, y - camera.y
			end
		end
		action = false
	end
end

function Mob:update()
	if self.isDead then
		return false
	else
		if self.isPlayer then
			if self.moves > 0 then
				self:action()
			end
		else
--			TODO ações tomadas pela IA do jogo
		end
	end
end

--#TODO
function Mob:draw(x,y)
	color = self.life*255/100
	if self.isPlayer then 
		love.graphics.setColor(0, 0, 255)
	else
		love.graphics.setColor(255, 0, 0)
	end
	printByTile(self.image,x,y);
	if self.isSelected then
		love.graphics.setColor(0, 255, 0)
		printByTile(selection,x,y)
	end
	love.graphics.setColor(255, 255, 255)
end
