Input = Object:extend()

function Input:new()
	self.lastClick = 0
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

function Input:mouseMap(key,delay,map) 
	if love.mouse.isDown( 1 ) and y <= 500 then
		clickTime = love.timer.getTime()
		setSelPos(math.floor(x / tileSize),math.floor(y / tileSize))
		if delay <= (clickTime - self.lastClick) then
			self.lastClick = clickTime
			x1, y1 = love.mouse.getPosition( )
			if x1 +75< x then
				map:cameraMove("right")
			elseif x1 -75> x then
				map:cameraMove("left")
			end
			if y1 -75 > y then
				map:cameraMove("up")
			elseif y1 +75< y then
				map:cameraMove("down")
		end
		x1,y1 = x,y
	end

	else
		x, y = love.mouse.getPosition( )
	end
end


function Input:update()
	input:down("up",delayClick,up)
	input:down("down",delayClick,down)
	input:down("left",delayClick,left)
	input:down("right",delayClick,right)
--	input:mouseMap(1,delayClick,map)
end
