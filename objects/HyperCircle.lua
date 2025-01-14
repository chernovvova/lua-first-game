HyperCircle = Object:extend()
HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, outer_radius, line_width)
    HyperCircle.super.new(self, x, y, radius)

    self.outer_radius = outer_radius
    self.line_width = line_width
end

function HyperCircle:draw()
    HyperCircle.super.draw(self)
    love.graphics.setLineWidth(self.line_width)
    love.graphics.circle('line', self.x, self.y, self.outer_radius)
end
