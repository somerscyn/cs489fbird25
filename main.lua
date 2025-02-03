local Push = require "push"
local Background = require "Background"
local Bird = require "Bird" 
gameWidth = 640
gameHeight = 480
gameState = "play" 

function love.load()
    love.window.setTitle("CS489 Flappy Bird")
    windowWidth, windowHeight = love.graphics.getDimensions()
    math.randomseed(os.time())
    
    Push:setupScreen(gameWidth,gameHeight,windowWidth,windowHeight
, {fullscreen = false, resizable = true})

    bg = Background()
    bird = Bird()

end

function love.resize(w,h)
    Push:resize(w,h)
end

function love.update(dt)
    bg:update(dt)
    bird:update(dt)
end

function love.draw()
    Push:start()
    bg:drawBackground()

    bg:drawForeground()
    bird:draw()

    Push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        bird:flap()
    end
end