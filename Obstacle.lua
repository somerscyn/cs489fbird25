local Class = require "hump.class"

local obSprite = love.graphics.newImage("sprites/pipe.png")

local Obstacle = Class{}
function Obstacle:init() 
    self.x = gameWidth+1 -- starts off-screen
    self.diffY = math.random(100,gameHeight-200)
    self.gap = 50
    self.scored = false 

    self.width = obSprite:getWidth()
    self.height = obSprite:getHeight()
end

function Obstacle:update(dt)
    self.x = self.x - 60*dt
end

function Obstacle:draw()
    love.graphics.draw(obSprite,self.x,self.diffY+self.gap) -- bottom pipe
    love.graphics.draw(obSprite,self.x,self.diffY-self.gap,0,1,-1) -- top pipe

    if debugFlag then
        love.graphics.rectangle("line",self.x,self.diffY+self.gap,self.width,self.height)
        love.graphics.rectangle("line",self.x,0,self.width,self.diffY-self.gap)
    end
end

function Obstacle:collision(bird)
    -- 1.x + width >= 2.x and 2.x+2.width >= 1.x
    local colX = self.x+self.width >= bird.x and bird.x+bird.width >= self.x

    -- 1.y+height >= 2.y and 2.y+height >= 1.y
    local botY = gameHeight >= bird.y and bird.y+bird.height >= self.diffY+self.gap
    local topY = self.diffY-self.gap >= bird.y and bird.y+bird.height >= 0

    return colX and (topY or botY)
end

return Obstacle