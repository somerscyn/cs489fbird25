local Push = require "push"
gameWidth = 640
gameHeight = 480
gameState = "play" 

function love.load()
    love.window.setTitle("CS489 Flappy Bird")
    windowWidth, windowHeight = love.graphics.getDimensions()
    math.randomseed(os.time())
    
    Push:setupScreen(gameWidth,gameHeight,windowWidth,windowHeight
, {fullscreen = false, resizable = true})

    bgClouds = love.graphics.newImage("bg/clouds.png")
    bgGround = love.graphics.newImage("bg/grass.png")

    bgCloudPos = 0
    bgGroundPos = 0
    bgWidth = bgClouds:getWidth() -- 853
    bgSpeed = 30

    birdSprites = {} -- creating an empty array
    birdSprites[1] = love.graphics.newImage("sprites/bird01.png")
    birdSprites[2] = love.graphics.newImage("sprites/bird02.png")
    birdSprites[3] = love.graphics.newImage("sprites/bird03.png")

    curSprite = 1
    timeLapsed = 0
end

function love.resize(w,h)
    Push:resize(w,h)
end

function love.update(dt)
    bgCloudPos = (bgCloudPos+bgSpeed*dt)%bgWidth
    bgGroundPos = (bgGroundPos+bgSpeed*2*dt)%bgWidth

    timeLapsed = timeLapsed + dt
    if timeLapsed >= 0.2 then
        curSprite = (curSprite%3)+1
        timeLapsed = 0
    end
end

function love.draw()
    Push:start()

    love.graphics.draw(bgClouds,-bgCloudPos,0)
    love.graphics.draw(bgClouds,bgWidth-bgCloudPos,0)
    love.graphics.draw(bgGround,-bgGroundPos,0)
    love.graphics.draw(bgGround,bgWidth-bgGroundPos,0)

    love.graphics.draw(birdSprites[curSprite],gameWidth/2-12,gameHeight/2 )

    Push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end