require "mob"

Mec = Object:extend()

--#TODO
function Mec:new(map) 
	tamX = map.tamX -1
	tamY = map.tamY -1
	self.mobs = {} -- lista de mobs
	mobsCounter = 0
	for i = 1, tamX do
		for j = 1, tamY do
			if i ~=1 and j ~= 1 and i ~= tamX and j ~=tamY then
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
	end
	self.turn = 0
end


--	#TODO estados:
--1. selecionado: entra no loop do mob em questão
--2. não selecionado: torna possivel a seleção de um mob
function Mec:update()
	if self.mob then
		if input:down("space") then
			self.mob:deSelection()
			self.mob = nil
		end
	else
		if input:down("kpenter") or input:down("return") then
			for _, mob in ipairs(self.mobs) do
				if actualTile.x == mob.pos.x and actualTile.y == mob.pos.y then
				self.mob = mob
				self.mob:selection()
				end
			end
		end
	end
end

function Mec:info()
	love.graphics.setColor(255, 0, 0)
	for _, mob in ipairs(self.mobs) do
		if mob.pos.x == actualTile.x and mob.pos.y == actualTile.y then
			if mob.isPlayer then
				love.graphics.print("Player", 12, 526)
			else
				love.graphics.print("Enemy", 12, 526)
			end

		end
	end
	if self.mob then
		love.graphics.print("Pos x "..self.mob.pos.x, 12, 540)
		love.graphics.print("Pos y "..self.mob.pos.y, 12, 550)
	end
	love.graphics.setColor(255, 255, 255)
end

function Mec:draw()
    for _, mob in ipairs(self.mobs) do
    	mob:draw(mob.pos.x - camera.x, mob.pos.y - camera.y )
    end
end
