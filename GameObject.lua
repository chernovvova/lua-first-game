GameObject = Object:extend()


function GameObject:new(area, x, y, opts)
    local opts = opts or {}
    if opts then
        for k, v in pairs(opts) do
            self[k] = v
        end
    end

    self.area = area
    self.x = x
    self.y = y
    self.id = UUID()
    self.dead = false
    self.timer = Timer()
    self.depth = 50
    self.creation_time = love.timer.getTime()
end


function GameObject:update(dt)
    if self.timer then
        self.timer:update(dt)
    end

    if self.fixture then
        self.x, self.y = self.fixture:getBody():getPosition()
    end
end


function GameObject:draw()

end


function GameObject:destroy()
    self.timer = nil
    if self.fixture then
        self.fixture:destroy()
    end
    self.fixture = nil
end
