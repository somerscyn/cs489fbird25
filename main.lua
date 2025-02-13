local Push = require "push"
local Background = require "Background"
local Bird = require "Bird" 
local ObstacleCourse = require "ObstacleCourse"
gameWidth = 640
gameHeight = 480
gameState = "start" 
debugFlag = false
highScore = 0

function love.load()
    love.window.setTitle("CS489 Flappy Bird")
    windowWidth, windowHeight = love.graphics.getDimensions()
    math.randomseed(os.time())

    titleFont = love.graphics.newFont(38)
    
    Push:setupScreen(gameWidth,gameHeight,windowWidth,windowHeight
, {fullscreen = false, resizable = true})

    bg = Background()
    bird = Bird()
    obsCourse = ObstacleCourse()

    -- Sound Dictionary / Table
    sounds = {} -- create an empty table
    sounds['music'] = love.audio.newSource("sounds/yummie.mp3","static")
    sounds['flap'] = love.audio.newSource("sounds/wingflap.wav","static")
    sounds['score'] = love.audio.newSource("sounds/pickup_coin.wav","static")
    sounds['collision'] = love.audio.newSource("sounds/hit_hurt.wav","static")
    -- starts off music
    sounds['music']:setLooping(true)
    sounds['music']:play()
end

function love.resize(w,h)
    Push:resize(w,h)
end

function love.update(dt)
    if gameState == "play" then
        bg:update(dt)
        bird:update(dt)
        --checking to see if we need to update the high schore
        -- comparing the score of the bird to the high schore
        if bird.score > highScore then
            highScore = bird.score
        end
        obsCourse:update(dt)

        obsCourse:scoring(bird)
        if obsCourse:collision(bird) then
            sounds["collision"]:play()
            gameState = "over"
        end
    end
end

function love.draw()
    Push:start()
    if gameState== "play" then
        drawPlayState()
    elseif gameState == "start" then
        drawStartState()
    elseif gameState == "over" then
        drawGameOverState()
    end

    Push:finish()
end

function drawStartState()
    bg:drawBackground()
    bg:drawForeground()

    love.graphics.printf("CS489 Flappy Bird",titleFont,0,100,gameWidth,"center")
    love.graphics.printf("Press Enter to Play again or Esc to exit",0,180,gameWidth,"center")
end

function drawPlayState()
    bg:drawBackground()
    
    obsCourse:draw()

    bg:drawForeground()

    bird:draw()
    
    love.graphics.print("Score: "..bird.score,titleFont,10,10)

    if debugFlag then
        love.graphics.print("FPS: "..love.timer.getFPS(),
        10,gameHeight-20)
    end
end

function drawGameOverState()
    love.graphics.printf("Game Over", titleFont,0,100,gameWidth,"center")
    love.graphics.printf("Score "..bird.score, titleFont,0,140,gameWidth,"center")
    love.graphics.printf("High Score "..highScore, titleFont, 0, 190, gameWidth, "center")
    love.graphics.printf("Press Enter to Play again or Esc to exit",0,240,gameWidth,"center")

end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" and gameState=="play" then
        bird:flap()
        sounds["flap"]:play()
    elseif key == "return" and gameState~="play" then
        bird = Bird()
        obsCourse = ObstacleCourse()
        gameState = "play"
    elseif key == "F2" or key=="tab" then
        debugFlag = not debugFlag
    else if key == "p" then
        -- pause the game
        
    end
    end
end