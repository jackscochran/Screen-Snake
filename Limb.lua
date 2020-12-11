Limb = Class{}

function Limb:init(thickness, x, y, back, front)
    self.thickness = thickness
    self.x = x
    self.y = y
    self.isTail = back
    self.isHead = front
    self.nextTail = 1
    
end

function Limb:render()
    love.graphics.rectangle('fill', self.x, self.y, self.thickness, self.thickness)
end

function Limb:move(x, y)
    self.x = x
    self.y = y
end