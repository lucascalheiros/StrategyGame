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
					self.plays[playsCounter] = mob
				elseif chance < 1 then
					mob = Mob(false,i,j)
					enemiesCounter = enemiesCounter + 1
					mobsCounter = mobsCounter + 1
					self.mobs[mobsCounter] =  mob
					self.enemies[enemiesCounter] = mob
				end
			end
		end
	end
	self.turn = 0
end

function Mec:mobAtPos(x,y)
	for _, mob in ipairs(self.mobs) do
		if mob.pos.x == x and mob.pos.y == y then
			return mob
		end
	end
	return nil
end

--	#TODO estados:
--1. selecionado: entra no loop do mob em questão
--2. não selecionado: torna possivel a seleção de um mob
function Mec:update()
	self.super.update(self, dt)

	actualTile = map:getActualTile(selPos.x, selPos.y)
	if self.mob then
		if not( self.mob:update() ) or input:isMouseReleased() or input:down("space") then 
			self.mob:deSelection()
			self.mob = nil
		end
	else
		input:mouseMap(1,-1,selToMousePos)
		input:down("up",delayClick,up)
		input:down("down",delayClick,down)
		input:down("left",delayClick,left)
		input:down("right",delayClick,right)
		if input:isMouseReleased() or input:down("kpenter") or input:down("return") then
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
		love.graphics.setColor(255, 255, 255,0.3)
		printByTile(selection, selPos.x, selPos.y)
	else
		if selectionBlink <= 40 then
			printByTile(selection, selPos.x, selPos.y)
		elseif selectionBlink >= 70 then
			selectionBlink = 0
		else
			love.graphics.setColor(255, 255, 255,0.3)
			printByTile(selection, selPos.x, selPos.y)
		end
	end
end

function Mec:draw()
    for _, mob in ipairs(self.mobs) do
    	mob:draw(mob.pos.x - camera.x, mob.pos.y - camera.y )
    end
    self:drawSelector()
end
