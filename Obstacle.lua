local Class = require "hump.class"

local obSprite = love.graphics.newImage("sprites/pipe.png")

local Obstacle = Class{}
function Obstacle:init() 
    self.x = gameWidth+1 -- starts off-screen
    self.y = math.random(100,200)
    self.gap = 50

    self.width = obSprite:getWidth()
    self.height = obSprite:getHeight()
end

function Obstacle:update(dt)
    self.x = self.x - 60*dt
end

function Obstacle:draw()
    love.graphics.draw(obSprite,self.x,self.y+self.gap)
    love.graphics.draw(obSprite,self.x,self.y-self.gap,0,1,-1)
end

return Obstacle