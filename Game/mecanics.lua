require "mob"

Mec = {}
Mec.__index = Mec

--#TODO
function Mec:new(tamX, tamY) 
	self.area = {} -- ligação entre mapa e mecanicas
	self.enemy = {} -- lista de mobs do inimigo
	self.player = {} -- lista de mobs do player
	playerCounter = 0
	enemyCounter = 0
	math.randomseed(os.time())
	for i = 1, tamY+1 do
		self.area[i] = {}
		for j = 1, tamX+1 do
			chance = math.random(0,20)
			if chance > 19 then
				playerCounter = playerCounter + 1
				self.player[playerCounter] =  Mob:new(true)
				self.area[i][j] = self.player[playerCounter]
			elseif chance < 1 then
				enemyCounter = enemyCounter + 1
				self.player[enemyCounter] =  Mob:new(false)
				self.area[i][j] =  self.player[enemyCounter]
			else
				self.area[i][j] = 0
			end
		end
	end
	self.turn = 0
	return setmetatable(self, Mec)
end

function Mec:turn()
	if sell.turn % 2 == 0 then 
		self:playerTurn()
	else
		self:machineTurn()
	end
end

function Mec:playerTurn()
	for key, value in ipairs(self.player) do 
	end
end

function Mec:machineTurn()
	for key, value in ipairs(self.enemy) do 
	end
end

function Mec:info()
	if self.area[actualTile.x][actualTile.y] ~= 0 then
		love.graphics.setColor(255, 0, 0)
		if self.area[actualTile.x][actualTile.y].isPlayer then
			love.graphics.print("Player", 12, 526)
		else
			love.graphics.print("Enemy", 12, 526)
		end
		love.graphics.setColor(255, 255, 255)
	end
end

function Mec:print()
    for i = camera.y, camera.y + rangeWindow.y do
        for j = camera.x , camera.x + rangeWindow.x do
            if self.area[j][i] ~= 0 then
				self.area[j][i]:print(j-camera.x,i-camera.y)
            end
        end
    end
end





