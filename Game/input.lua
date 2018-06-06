Input = {}
Input.__index = Input

function Input:new()
	self.lastClick = 0
	return setmetatable(self,Input)
end

function Input:delay(delay, func) 
	clickTime = love.timer.getTime()
	if delay <= (clickTime - self.lastClick) then
		self.lastClick = clickTime
		func()
	end
end

function Input:down(key, delay, func) 
	if love.keyboard.isDown(key) then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			func()
		end
	end
end
