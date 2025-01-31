local Class = require "hump.class"

local Background = Class{}
function Background:init()
    self.bgClouds = love.graphics.newImage("bg/clouds.png")
    self.bgGround = love.graphics.newImage("bg/grass.png")
    -- incomplete code, we will continue on the next lecture
    bgCloudPos = 0
    bgGroundPos = 0
    bgWidth = bgClouds:getWidth() -- 853
    bgSpeed = 30

end

return Background