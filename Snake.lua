Snake = Class{}

function Snake:init(thickness)
    self.thickness = thickness
    self.numOfLimbs = 0
    self.x = WINDOW_WIDTH/2
    self.y = 300
    self.dy = 0
    self.dx = 1
    self.limbs = {}
end

function Snake:render()
    for i = 1, self.numOfLimbs, 1 do
        self.limbs[i]:render()
    end
end

function Snake:newLimb()

    self.numOfLimbs = self.numOfLimbs + 1

    
    if self.numOfLimbs == 1 then 
        self.limbs[self.numOfLimbs] = Limb(self.thickness, self.x, self.y, true, true)

    else
        tailIndex = snake:tail()
        back = self.limbs[tailIndex]

        if self.numOfLimbs > 2 then
            m = 0
        else
            m = 1
        end
        x = back.x - self.thickness * self.dx * m
        y = back.y - self.thickness * self.dy * m
        self.limbs[snake:tail()].isTail = false
        self.limbs[self.numOfLimbs] = Limb(self.thickness, x, y, true, false)
        self.limbs[self.numOfLimbs].nextTail = tailIndex
    end
end

function Snake:head()
    for i = 1, self.numOfLimbs, 1 do
        if self.limbs[i].isHead then
            return i
        end
    end
end

function Snake:tail()
    for i = 1, self.numOfLimbs, 1 do
        if self.limbs[i].isTail then
            return i
        end
    end
end

function Snake:collides(box)
    x = snake.limbs[snake:head()].x
    y = snake.limbs[snake:head()].y
    
    if box.x >= x + SNAKE_GIRTH or x >= box.x + SNAKE_GIRTH then
        return false
    end

    
    if box.y >= y + SNAKE_GIRTH or y >= box.y + SNAKE_GIRTH then
        return false
    end 

    return true
end











