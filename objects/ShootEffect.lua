ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
    ShootEffect.super.new(self, area, x, y, opts)

    self.w = 8
    self.timer:tween(0.1, self, {w = 0}, 'in-out-cubic', function() self.dead = true end)
end


function ShootEffect:update(dt)
    ShootEffect.super.update(self, dt)

    if self.player then
        self.x = self.player.x + self.d*math.cos(self.player.r)
        self.y = self.player.y + self.d*math.sin(self.player.r)
    end
end


function pushRotate(x, y, r)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.translate(-x, -y)
end


function pushRotateScale(x, y, r, sx, sy)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.scale(sx or 1, sy or sx or 1)
    love.graphics.translate(-x, -y)
end


function ShootEffect:draw()
    pushRotate(self.x, self.y, self.player.r + math.pi / 4)
    love.graphics.setColor(default_color)
    love.graphics.rectangle(
        'fill',
        self.x - self.w/2,
        self.y - self.w/2,
        self.w,
        self.w
    )
    love.graphics.pop()
end


function ShootEffect:destroy()
    ShootEffect.super.destroy(self)
end
