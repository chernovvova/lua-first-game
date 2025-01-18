Player = GameObject:extend()

function Player:new(area, x, y, opts)
    Player.super.new(self, area, x, y, opts)

    self.x, self.y = x, y
    self.w, self.h = 12, 12

    local shape = love.physics.newCircleShape(self.w)
    local body = love.physics.newBody(self.area.world, self.x, self.y, 'dynamic')
    local fixture = love.physics.newFixture(body, shape)

    self.collider = fixture
end

function Player:update(dt)
    Player.super.update(self, dt)
end

function Player:draw()
    love.graphics.circle('line', self.x, self.y, self.w)
end
