local Class = require "hump.class"

local bgClouds = love.graphics.newImage("bg/clouds.png")
local bgGround = love.graphics.newImage("bg/grass.png")

local Background = Class{}
function Background:init()
    self.bgCloudPos = 0
    self.bgGroundPos = 0
    self.bgWidth = bgClouds:getWidth() -- 853
    self.bgSpeed = 30
end

function Background:update(dt)
    self.bgCloudPos = (self.bgCloudPos+self.bgSpeed*dt)%self.bgWidth
    self.bgGroundPos = (self.bgGroundPos+self.bgSpeed*2*dt)%self.bgWidth
end

function Background:drawBackground()
    love.graphics.draw(bgClouds,-self.bgCloudPos,0)
    love.graphics.draw(bgClouds,self.bgWidth-self.bgCloudPos,0)
end

function Background:drawForeground()
    love.graphics.draw(bgGround,-self.bgGroundPos,0)
    love.graphics.draw(bgGround,self.bgWidth-self.bgGroundPos,0)
end


return Background