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

function Input:downUp(delay, func) 
	if love.keyboard.isDown("up") then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			func()
		end
	end
end

function Input:downDn(delay, func) 
	if love.keyboard.isDown("down") then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			func()
		end
	end
end

function Input:downLt(delay, func) 
	if love.keyboard.isDown("left") then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			func()
		end
	end
end

function Input:downRt(delay, func) 
	if love.keyboard.isDown("right") then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			func()
		end
	end
end
