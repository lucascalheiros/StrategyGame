local GameLoop = Object:extend()

function GameLoop:new()
    self.game_objects = {}
end

function GameLoop:update(dt)
    if self.game_objects then
        for i = #self.game_objects, 1, -1 do
            local game_object = self.game_objects[i]
            game_object:update(dt)

            if game_object.dead then
                game_object:destroy()
                table.remove(self.game_objects, i)
            end
        end
    end
end

function GameLoop:draw()
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function GameLoop:addGameObject(game_object_type, x, y, opts)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
    table.insert(self.game_objects, game_object)

    return game_object
end

return GameLoop
