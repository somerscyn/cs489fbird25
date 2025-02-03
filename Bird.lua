local Class = require "hump.class"

local birdSprites = {} -- creating an empty array
birdSprites[1] = love.graphics.newImage("sprites/bird01.png")
birdSprites[2] = love.graphics.newImage("sprites/bird02.png")
birdSprites[3] = love.graphics.newImage("sprites/bird03.png")

local Bird = Class{}
function Bird:init() 
    self.x = gameWidth/2-12
    self.y = gameHeight/2
    self.width = birdSprites[1]:getWidth()
    self.height = birdSprites[1]:getHeight()
    self.curSprite = 1
    self.timeLapsed = 0

    self.fly = 0
    self.gravity = 2
    self.speed = 0
end

function Bird:update(dt)
    -- Code for Changing the Sprite
    self.timeLapsed = self.timeLapsed + dt
    if self.timeLapsed >= 0.2 then
        self.curSprite = (self.curSprite%(#birdSprites))+1
        self.timeLapsed = 0
    end
    -- For the Fly/Gravity
    if self.fly > 0 then -- flapped wings
        self.y = self.y - self.fly*dt
        self.fly = self.fly-60*dt
    else -- did not flap, it is falling
        self.speed = self.speed + self.gravity*dt
        self.y = self.y + self.speed 
    end
    
end

function Bird:draw()
    love.graphics.draw(birdSprites[self.curSprite],self.x,self.y )
end

function Bird:flap()
    self.fly = 80 
    self.speed = 0
end

return Bird