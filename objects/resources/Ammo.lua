Ammo = GameObject:extend()


function Ammo:new(area, x, y, opts)
    Ammo.super.new(self, area, x, y, opts)

    self.w, self.h = 8, 8

    local shape = love.physics.newRectangleShape(self.x, self.y, self.w, self.h)
    local body = love.physics.newBody(area.world, self.x, self.y, 'dynamic')
    self.fixture = love.physics.newFixture(body, shape)
    self.fixture:getBody():setFixedRotation(false)

    self.r = random(0, 2 * math.pi)
    self.v = random(10, 20)

    self.fixture:getBody():setLinearVelocity(
        self.v * math.cos(self.r),
        self.v * math.sin(self.r)
    )
    self.fixture:getBody():applyAngularImpulse(random(-24, 24))
end


function Ammo:update(dt)
    Ammo.super.update(self, dt)
end


function Ammo:draw()
    love.graphics.setColor(AMMO_COLOR)
    pushRotate(self.x, self.y, self.fixture:getBody():getAngle())
    draft:rhombus(self.x, self.y, self.w, self.h, 'line')
end


function Ammo:destroy()
    Ammo.super.destroy(self)
end
