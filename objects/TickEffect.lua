TickEffect = GameObject:extend()


function TickEffect:new(area, x, y, opts)
    TickEffect.super.new(self, area, x, y, opts)
    self.depth = 75

    self.w = 48
    self.h = 32

    self.y_offset = 0
    self.timer:tween(
        0.13,
        self,
        {h = 0, y_offset = 32},
        'in-out-cubic',
        function() self.dead = true end
    )
end


function TickEffect:update(dt)
    TickEffect.super.update(self, dt)

    if self.parent then
        self.x = self.parent.x
        self.y = self.parent.y - self.y_offset
    end
end

function TickEffect:draw()
    love.graphics.setColor(love.math.colorFromBytes(colors.DEFAULT_COLOR))
    love.graphics.rectangle(
        'fill',
        self.x - self.w / 2,
        self.y,
        self.w,
        self.h
    )
    love.graphics.setColor(255, 255, 255)
end


function TickEffect:destroy()
    TickEffect.super.destroy(self)
end
