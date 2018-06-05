Mec = {}
Mec.__index = Mec

function Mec:new(tamX, tamY) 
	self.area = {} -- ligação entre mapa e mecanicas
	self.enemy = {} -- lista de mobs do inimigo
	self.player = {} -- lista de mobs do player
	for i = 1, tamY do
		self.area[i] = {}
		for j = 1, tamX do
			self.area[i][j] = 0
		end
	end
	self.turn = 0
	
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







