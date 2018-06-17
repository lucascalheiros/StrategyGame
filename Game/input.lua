Input = Object:extend()

function Input:new()
	self.lastClick = 0
	self.mouse = {
	x = 0,
	y = 0
	}
	self.mouseReleased = {}
	self.keyReleased = {}
end

function Input:delay(delay, func) 
	clickTime = love.timer.getTime()
	if delay <= (clickTime - self.lastClick) then
		self.lastClick = clickTime
		func()
	end
end

function Input:down(key, delay, func ) 
	delay = delay or 0
	func = func or nil
	if love.keyboard.isDown(key) then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			if func then
				func()
			end
		return true
		end
	end
	return false
end

--	 Entrada do mose que funciona apenas da area do mapa
function Input:mouseMap(key,delay,func) 
	if love.mouse.isDown( 1 ) and self.mouse.y <= 500 then
		clickTime = love.timer.getTime()
		if delay <= (clickTime - self.lastClick) then
			if delay ~= -1 then
				self.lastClick = clickTime
			end
			if func then
				func()
			end
			return true
		end
	else
		self.mouse.x, self.mouse.y = love.mouse.getPosition( )
		return false
	end
end

function Input:isKeyReleased( key )
	if self.keyReleased[key] then 
		self.keyReleased[key] = false
		return true
	end
	return false
end

function Input:isMouseReleased( key )
	if self.mouseReleased[key] then
		self.mouseReleased[key] = false
		return true
	end
	return false
end

function love.keyreleased( key ) 
	input.keyReleased[key] = true
end

function love.mousereleased( x, y, button, istouch )
	if button == 1 then
		input.mouseReleased["1"] = true 
	elseif button == 2 then
		input.mouseReleased["2"] = true
	elseif button == 3 then
		input.mouseReleased["3"] = true
	end
end

