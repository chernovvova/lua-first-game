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
    self.base_max_v = 100
    self.max_v = self.base_max_v  -- max velocity
    self.a = 100  -- acceleration


    self.attack_speed = 1
    self.timer:every(0.24 / self.attack_speed, function() self:shoot() end)

    input:bind('f4', function() self:die() end)

    self.timer:every(5, function() self:tick() end)

    self.trail_color = SHIP_TRAIL_PARTICLE_COLOR
    self.timer:every(
        0.01,
        function()
            self.area:addGameObject(
                'TrailParticle',
                self.x - self.w * math.cos(self.r),
                self.y - self.h * math.sin(self.r),
                {
                    parent = self,
                    r = random(2, 4),
                    d = random(0.15, 0.25),
                    color = self.trail_color
                }
            )
        end)
end

function Player:update(dt)
    Player.super.update(self, dt)

    if input:down('left') then
        self.r = self.r - self.rv * dt
    end

    if input:down('right') then
        self.r = self.r + self.rv * dt
    end

    self.max_v = self.base_max_v
    self.boosting = false

    if input:down('up') then
        self.boosting = true
        self.max_v = 1.5 * self.base_max_v
    end
    if input:down('down') then
        self.boosting = true
        self.max_v = 0.5 * self.base_max_v
    end

    self.trail_color = SHIP_TRAIL_PARTICLE_COLOR
    if self.boosting then
        self.trail_color = BOOST_COLOR
    end

    self.v = math.min(self.v + self.a * dt, self.max_v)
    self.fixture:getBody():setLinearVelocity(
        self.v * math.cos(self.r),
        self.v * math.sin(self.r)
    )

    if self.x < 0 or self.y < 0 or self.x > gw or self.y > gh then
        self:die()
    end
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


function Player:shoot()
    local d = 1.2 * self.w

    self.area:addGameObject(
        'ShootEffect',
        self.x + d * math.cos(self.r),
        self.y + 1.2 * self.w * math.sin(self.r),
        {player = self, d = d}
    )
    self.area:addGameObject(
        'Projectile',
        self.x + 1.5 * d * math.cos(self.r),
        self.y + 1.5 * d * math.sin(self.r),
        {r = self.r}
    )
end

function Player:die()
    self.dead = true
    flash(0.005)
    camera:shake(6, 60, 0.4)
    slow(0.15, 1)

    for i = 1, love.math.random(20, 30) do
        self.area:addGameObject(
            'ExplodeParticle',
            self.x,
            self.y,
            {color = EXPLODE_PARTICLE_COLORS[love.math.random(1, 3)]}
        )
    end
end


function Player:tick()
    self.area:addGameObject('TickEffect', self.x, self.y, {parent = self})
end
