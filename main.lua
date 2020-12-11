
Class = require 'class'
require 'Snake'
require 'Limb'
require 'Food'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
SNAKE_SPEED = 0.07
SNAKE_GIRTH = 20

score = 0

function love.load()

    math.randomseed(os.time())

    largeFont = love.graphics.newFont('font.ttf', 48)
    mediumFont = love.graphics.newFont('font.ttf', 32)
    smallFont = love.graphics.newFont('font.ttf', 16)

    gameMode = 'wallTele'
    gameState = 'start'
    snake = Snake(SNAKE_GIRTH)
    snake:newLimb()
    food = Food()
    
end

function love.update()
    if gameState == 'play' then
        --snake collistion
        if snake:collides(food) then
            food:move()
            snake:newLimb()
            score = score + 1
        end

        --wall collision
        headX = snake.limbs[snake:head()].x
        headY = snake.limbs[snake:head()].y
        if headX < 0 or headX >= WINDOW_WIDTH or headY < 0 or headY >= WINDOW_HEIGHT then
            if gameMode == 'wallCollision' then
                gameState = 'gameOver'
            elseif gameMode == 'wallTele' then
                x = snake.limbs[head].x
                y = snake.limbs[head].y
                if snake.dx == 1 then
                    x = 0 - SNAKE_GIRTH
                elseif snake.dx == -1 then
                     x = WINDOW_WIDTH
                elseif snake.dy == 1 then
                     y = 0 - SNAKE_GIRTH
                elseif snake.dy == -1 then
                     y = WINDOW_HEIGHT
                end
                snake.limbs[tail]:move(x, y)
            end
        end

        for i = 1, snake.numOfLimbs, 1 do
            if snake:collides(snake.limbs[i]) and i ~= snake:head() then
                gameState = "gameOver"
            end
        end
        
        -- snake movement
        head = snake:head()
        tail = snake:tail()

        if snake.dx == 1 then
            x = snake.limbs[head].x + SNAKE_GIRTH
            y = snake.limbs[head].y
        elseif snake.dx == -1 then
            x = snake.limbs[head].x - SNAKE_GIRTH
            y = snake.limbs[head].y
        elseif snake.dy == 1 then
            x = snake.limbs[head].x 
            y = snake.limbs[head].y + SNAKE_GIRTH
        elseif snake.dy == -1 then
            x = snake.limbs[head].x 
            y = snake.limbs[head].y - SNAKE_GIRTH
        end

        snake.limbs[tail]:move(x, y)
        
        if snake.numOfLimbs > 1 then

            snake.limbs[head].isHead = false
            snake.limbs[tail].isTail = false
            snake.limbs[tail].isHead = true

            snake.limbs[head].nextTail = tail
            
            snake.limbs[snake.limbs[tail].nextTail].isTail = true

        end

        love.timer.sleep(SNAKE_SPEED)
    end
end

function love.draw()
    if gameState == 'start' then
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Snake", 0, 20, WINDOW_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("press enter to begin", 0, 60, WINDOW_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Score: " .. score, 0, 20, WINDOW_WIDTH, 'center')
    elseif gameState == 'gameOver' then
        love.graphics.setFont(largeFont)
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf("Game Over!", 0, 250, WINDOW_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Score: " .. score, 0, 310, WINDOW_WIDTH, 'center')


    end

    if gameState ~= 'gameOver' then
        snake:render()
        food:render()
    end
end

function love.keypressed(key)
    if key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
            food:move()
        elseif gameState == 'play' then
            gameState = 'start'
        elseif gameState == 'gameOver' then
            snake = Snake(SNAKE_GIRTH)
            snake:newLimb()
            food = Food()
            score = 0
            gameState = 'start'
        end
    end

    if key == 'w' and snake.dy ~= 1 then
        snake.dy = -1
        snake.dx = 0
    elseif key == 's' and snake.dy ~= -1 then
        snake.dy = 1
        snake.dx = 0
    elseif key == 'd' and snake.dx ~= -1 then
        snake.dx = 1
        snake.dy = 0
    elseif key == 'a' and snake.dx ~= 1 then
        snake.dx = -1
        snake.dy = 0
    end

    if key == 't' then
        snake:newLimb()
        food:move()
    end
end
