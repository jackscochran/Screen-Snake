Food = Class{}

function Food:init()
    self.x = WINDOW_WIDTH/2
    self.y = 300
end

function Food:render()
    love.graphics.rectangle('fill', self.x, self.y, SNAKE_GIRTH, SNAKE_GIRTH)
end

function Food:move()
    xRange = WINDOW_WIDTH/SNAKE_GIRTH - 1
    yRange = WINDOW_HEIGHT/SNAKE_GIRTH - 1
    self.x = math.random(0, xRange) * SNAKE_GIRTH
    self.y = math.random(0, yRange) * SNAKE_GIRTH
end



