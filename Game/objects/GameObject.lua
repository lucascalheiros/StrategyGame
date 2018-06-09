local GameObject = Object:extend()

function GameObject:new(x, y, opts)
    local opts = opts or {}
    if opts then for k, v in pairs(opts) do self[k] = v end end

    self.pos = {
        x = x or 0,
        y = y or 0
    }

    self.dead = false
    self.timer = Timer()
end

function GameObject:update(dt)
    if self.timer then self.timer:update(dt) end
end

function GameObject:draw()
end

function GameObject:destroy()
    self.timer:destroy()
end

return GameObject
