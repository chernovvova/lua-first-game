TrailParticle = GameObject:extend()


function TrailParticle:new(area, x, y, opts)
    TrailParticle.super.new(self, area, x, y, opts)

    self.r = self.r or random(4, 6)
    self.timer:tween(
        self.d or random(0.3, 0.5),
        self,
        {r=0},
        'linear',
        function() self.dead = true end
    )
end


function TrailParticle:update(dt)
    TrailParticle.super.update(self, dt)
end


function TrailParticle:draw()
    love.graphics.setColor(love.math.colorFromBytes(self.color))
    love.graphics.circle('fill', self.x, self.y, self.r)
    love.graphics.setColor(255, 255, 255)
end


function TrailParticle:destroy()
    TrailParticle.super.destroy(self)
end
