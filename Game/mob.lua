Mob = GameObject:extend()

--#TODO
function Mob:new(isPlayer,x0,y0)
	self.super.new(self, x0, y0)
	self.name = "Knight"
	self.maxLife = 100
	self.life = 100
	self.maxMove = 5
	self.moves = 5
	self.atk = 30
	self.def = 0
	self.isPlayer = isPlayer
	self.image = love.graphics.newImage( "/resources/tiles/mob.png" )
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
	enemy:isDead()
	self.moves = 0
end

function Mob:isDead()
	if self.life <= 0 then
		self.life = 0
		self.dead = true
	end
end

function Mob:enemyBehaviour()
	local target = nil

	for _, player in ipairs(mec.plays) do
		if target == nil then
			if player.dead == false then
				target = player
			end
		else
			if distance(self.pos.x, self.pos.y, target.pos.x, target.pos.y)
			>= distance(self.pos.x, self.pos.y, player.pos.x, player.pos.y)
			and player.dead == false then
				target = player
			end
		end
	end

	if target then
		for i = 1, 5 do
			local x, y = self.pos.x, self.pos.y
			if self.pos.x > target.pos.x then
				x = x - 1
			elseif self.pos.x < target.pos.x then
				x = x + 1
			else
				if self.pos.y > target.pos.y then
					y = y - 1
				else
					y = y + 1
				end
			end

			local mob = mec:mobAtPos(x,y)
			if mob and mob.dead == false then
				if mob.isPlayer then
					self:attack(mob)
					break
				end
			else
				local moveCost = map.map[x][y].moveCost
				local remainMoves = self.moves - moveCost
				if remainMoves >= 0 then
					self.moves = remainMoves
					self.pos.x, self.pos.y = x, y
					selPos.x, selPos.y = x - camera.x, y - camera.y
				end
			end
		end
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
		if mob and not mob.dead then
			if not mob.isPlayer then
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

function Mob:endTurn()
	self.moves = self.maxMove
end

function Mob:update(dt)
	self.super.update(self, dt)

	if self.dead then
		return false
	else
		if self.isPlayer then
			if self.moves > 0 then
				self:action()
			else
				return false
			end
		else
			self:enemyBehaviour()
		end
		return true
	end

	self:isDead()
end

--#TODO
function Mob:draw(x,y)
	color = self.life/100
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
