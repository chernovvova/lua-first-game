Projectile = GameObject:extend()

function Projectile:new(area, x, y, opts)
    Projectile.super.new(self, area, x, y, opts)

    self.s = opts.s or 2.5  -- collider radius
    self.v = opts.v or 200  -- velocity

    local shape = love.physics.newCircleShape(self.s)
    local body = love.physics.newBody(area.world, self.x, self.y, 'dynamic')
    local fixture = love.physics.newFixture(body, shape, 1)

    self.fixture = fixture

    self.fixture:getBody():setLinearVelocity(
        self.v * math.cos(self.r),
        self.v * math.sin(self.r)
    )
end


function Projectile:update(dt)
    Projectile.super.update(self, dt)
    self.fixture:getBody():setLinearVelocity(
        self.v * math.cos(self.r),
        self.v * math.sin(self.r)
    )

    if self.x < 0 or self.y < 0 or self.x > gw or self.y > gh then
        self:die()
    end
end


function Projectile:draw()
    love.graphics.setColor(love.math.colorFromBytes(colors.DEFAULT_COLOR))
    love.graphics.circle(
        'line',
        self.fixture:getBody():getX(),
        self.fixture:getBody():getY(),
        self.fixture:getShape():getRadius()
    )
end


function Projectile:destroy()
    Projectile.super.destroy(self)
end


function Projectile:die()
    self.dead = true
    self.area:addGameObject(
        'ProjectileDeathEffect',
        self.x,
        self.y,
        {
            color=self.color or colors.PROJECTILE_DEATH_COLOR,
            w=3*self.s
        }
    )
end
