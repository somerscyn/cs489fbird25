local Class = require "hump.class"
local Obstacle = require "Obstacle"

local ObstacleCourse = Class{}
function ObstacleCourse:init()
    self.arrayObs = {}
    self.arrayObs[1] = Obstacle()

    self.timeLapsed = 0
end

function ObstacleCourse:update(dt)
    -- This is to update the obstacles
    for index,obs in pairs(self.arrayObs) do --for each loop
        obs:update(dt)
    end
    -- This code is here to spawn new obs
    self.timeLapsed = self.timeLapsed+dt
    if self.timeLapsed >= 4 then
        self.timeLapsed = 0
        local newObs = Obstacle()
        table.insert( self.arrayObs, newObs )
    end
    -- Remove obstacles that off-screen to the left
    if self.arrayObs[1].x < 0-self.arrayObs[1].width then
       -- we could also check for x+width < 0  
        
        table.remove(self.arrayObs, 1)
    end
end

function ObstacleCourse:draw()
    for i=1, #self.arrayObs do -- for i loop
        self.arrayObs[i]:draw()
    end
end

function ObstacleCourse:collision(bird)
    for index,obs in pairs(self.arrayObs) do
        if obs:collision(bird) then
            return true
        end --end if
    end -- end for
    return false
end

function ObstacleCourse:scoring(bird)
    for index,obs in pairs(self.arrayObs) do
        if obs.scored == false 
            and obs.x+obs.width < bird.x then
            bird.score = bird.score +1
            obs.scored = true
        end
    end
end

return ObstacleCourse