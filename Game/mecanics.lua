require "mob"

Mec = GameObject:extend()

--#TODO
function Mec:new(map)
	self.super.new(self)

	tamX = map.tamX -1
	tamY = map.tamY -1
	self.mobs = {} -- lista de mobs
	self.enemies = {}
	self.plays = {}
	playsCounter = 0
	enemiesCounter = 0
	mobsCounter = 0
	for i = 1, tamX do
		for j = 1, tamY do
			if i ~=1 and j ~= 1 and i ~= tamX and j ~=tamY then
				chance = love.math.random(0,20)
				if chance > 19 then
					playsCounter = playsCounter + 1
					mobsCounter = mobsCounter + 1
					mob = Mob(true,i,j)
					self.mobs[mobsCounter] = mob
					self.plays[playsCounter] = self.mobs[mobsCounter]
				elseif chance < 1 then
					mob = Mob(false,i,j)
					enemiesCounter = enemiesCounter + 1
					mobsCounter = mobsCounter + 1
					self.mobs[mobsCounter] =  mob
					self.enemies[enemiesCounter] = self.mobs[mobsCounter]
				end
			end
		end
	end
	self.turn = true
	self.count = 1
end

function Mec:mobAtPos(x,y)
	for _, mob in ipairs(self.mobs) do
		if mob.pos.x == x and mob.pos.y == y then
			return mob
		end
	end
	return nil
end

function Mec:update(dt)
	self.super.update(self, dt)
	if self.turn then
		self:playerTurn()
	else
		self:enemyTurn()
	end
	if input:isKeyReleased("return") then
		self.turn = false
	end
end

function Mec:enemyTurn()
	if self.count <= #self.enemies then
		self.enemies[self.count]:update()
		self.count = self.count + 1
	else
		self.count = 1
		self.turn = true
		for _,mob in ipairs(self.mobs) do
			if not mob.dead then mob:endTurn() end
		end
	end
end

function Mec:playerTurn()
	actualTile = map:getActualTile(selPos.x, selPos.y)
	if self.mob then
		if not self.mob:update() or input:isMouseReleased("1") or input:down("space") then
			self.mob:deSelection()
			self.mob = nil
		end
	else
		input:mouseMap(1,-1,selToMousePos)
		input:down("up",delayClick,up)
		input:down("down",delayClick,down)
		input:down("left",delayClick,left)
		input:down("right",delayClick,right)
		if input:isMouseReleased("1") or input:down("kpenter") then
			for _, mob in ipairs(self.plays) do
				if actualTile.x == mob.pos.x and actualTile.y == mob.pos.y then
				self.mob = mob
				self.mob:selection()
				end
			end
		end
	end
end

function Mec:drawSelector()
	if self.mob then
		love.graphics.setColor(1, 1, 1,0.3)
		printByTile(selection, selPos.x, selPos.y)
	else
		if selectionBlink <= 40 then
			printByTile(selection, selPos.x, selPos.y)
		elseif selectionBlink >= 70 then
			selectionBlink = 0
		else
			love.graphics.setColor(1, 1, 1,0.3)
			printByTile(selection, selPos.x, selPos.y)
		end
	end
end

function Mec:draw()
    for _, mob in ipairs(self.mobs) do
    	if mob then
    		mob:draw(mob.pos.x - camera.x, mob.pos.y - camera.y )
    	end
    end
    self:drawSelector()
end
