Player = GameObject:extend()

function Player:new(area, x, y, opts)
    Player.super.new(self, area, x, y, opts)

    self.x, self.y = x, y
    self.w, self.h = 12, 12

    local shape = love.physics.newCircleShape(self.w)
    local body = love.physics.newBody(area.world, self.x, self.y, 'dynamic')
    local fixture = love.physics.newFixture(body, shape, 1)

    self.fixture = fixture

    self.r = -math.pi / 2  -- player moving angle
    self.rv = 1.66 * math.pi  -- angle change velocity
    self.v = 0  -- plater velocity
    self.max_v = 100  -- max velocity
    self.a = 100  -- acceleration
end

function Player:update(dt)
    Player.super.update(self, dt)

    if input:down('left') then
        self.r = self.r - self.rv * dt
    end

    if input:down('right') then
        self.r = self.r + self.rv * dt
    end

    self.v = math.min(self.v + self.a * dt, self.max_v)
    self.fixture:getBody():setLinearVelocity(
        self.v * math.cos(self.r),
        self.v * math.sin(self.r)
    )
end

function Player:draw()
    love.graphics.circle(
        'line',
        self.fixture:getBody():getX(),
        self.fixture:getBody():getY(),
        self.fixture:getShape():getRadius()
    )
    love.graphics.line(
        self.x,
        self.y,
        self.x + 2*self.w*math.cos(self.r),
        self.y + 2*self.w*math.sin(self.r)
    )
end
