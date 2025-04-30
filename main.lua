require "menu"
require "gameplay"
require "gameplayover"

local angle = 0
local rotationSpeed = math.pi
local rotating = false
local paused = false
local cameraX = 0
local scrollSpeed = 200
local orbclick = false
local gameTime = 0
local bestTime = 0
local timeRunning = false

function love.load()
    medium = love.graphics.newFont(45)
    small = love.graphics.newFont(30)

    gamestate = 'menu'

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81 * 64, true)

    ballShape = love.physics.newCircleShape(25)
    ball1 = love.physics.newBody(world, 1750, 370, "static")
    ballFixture1 = love.physics.newFixture(ball1, ballShape)
    ballFixture1:setUserData("ball")
    ballFixture1:setSensor(true)

    blockShape = love.physics.newRectangleShape(50, 50)
    blockShape1 = love.physics.newRectangleShape(50, 125)
    blockShape2 = love.physics.newRectangleShape(50, 25)

    block1 = love.physics.newBody(world, 1200, 440, "static")
    blockFixture1 = love.physics.newFixture(block1, blockShape)
    blockFixture1:setUserData("block")

    block2 = love.physics.newBody(world, 1400, 440, "static")
    blockFixture2 = love.physics.newFixture(block2, blockShape1)
    blockFixture2:setUserData("block")

    block3 = love.physics.newBody(world, 1200, 420, "static")
    blockFixture3 = love.physics.newFixture(block3, blockShape2)

    block4 = love.physics.newBody(world, 1400, 380, "static")
    blockFixture4 = love.physics.newFixture(block4, blockShape2)

    spikeShape = love.physics.newPolygonShape(
        0, 0,
        50, 100,
        -50, 100
    )
    spikeShape1 = love.physics.newPolygonShape(
        0, 25,
        100, 100,
        -100, 100
    )

    spike1 = love.physics.newBody(world, 540, 420, "static")
    spikeFixture1 = love.physics.newFixture(spike1, spikeShape)
    spikeFixture1:setUserData("spike")

    spike2 = love.physics.newBody(world, 580, 420, "static")
    spikeFixture2 = love.physics.newFixture(spike2, spikeShape)
    spikeFixture2:setUserData("spike")

    spike3 = love.physics.newBody(world, 780, 420, "static")
    spikeFixture3 = love.physics.newFixture(spike3, spikeShape)
    spikeFixture3:setUserData("spike")

    spike4 = love.physics.newBody(world, 820, 420, "static")
    spikeFixture4 = love.physics.newFixture(spike4, spikeShape)
    spikeFixture4:setUserData("spike")

    spike5 = love.physics.newBody(world, 860, 420, "static")
    spikeFixture5 = love.physics.newFixture(spike5, spikeShape)
    spikeFixture5:setUserData("spike")

    spike6 = love.physics.newBody(world, 1690, 420, "static")
    spikeFixture6 = love.physics.newFixture(spike6, spikeShape1)
    spikeFixture6:setUserData("spike")

    spike7 = love.physics.newBody(world, 1730, 420, "static")
    spikeFixture7 = love.physics.newFixture(spike7, spikeShape1)
    spikeFixture7:setUserData("spike")

    spike8 = love.physics.newBody(world, 1770, 420, "static")
    spikeFixture8 = love.physics.newFixture(spike8, spikeShape1)
    spikeFixture8:setUserData("spike")

    spike9 = love.physics.newBody(world, 1810, 420, "static")
    spikeFixture9 = love.physics.newFixture(spike9, spikeShape1)
    spikeFixture9:setUserData("spike")

    ground = {}
    ground.body = love.physics.newBody(world, 400, 480, "static")
    ground.shape = love.physics.newRectangleShape(800, 40)
    ground.fixture = love.physics.newFixture(ground.body, ground.shape)

    groundShape = love.physics.newRectangleShape(800, 40)

    ground1 = love.physics.newBody(world, 400, 480, "static")
    groundFixture1 = love.physics.newFixture(ground1, groundShape)

    ground2 = love.physics.newBody(world, 1200, 480, "static")
    groundFixture2 = love.physics.newFixture(ground2, groundShape)

    player = {}
    player.body = love.physics.newBody(world, 225, 400, "dynamic")
    player.shape = love.physics.newRectangleShape(50, 50)
    player.fixture = love.physics.newFixture(player.body, player.shape, 1)
    player.fixture:setUserData("player")

    buttons_spawn(300, 185, "Start", "start")
    buttons_spawn(308, 235, "Quit", "quit")
    button_spawn(75, 200, "Restart", "restartagain")
    button_spawn(85, 250, "Menu", "btm")
    button_spawn(100, 300, "Quit", "quitagain")
    buttonz_spawn(275, 185, "Restart", "restart")
    buttonz_spawn(290, 235, "Menu", "menuagain")
    buttonz_spawn(308, 285, "Quit", "quit2")

    world:setCallbacks(beginContact)
end

function love.update(dt)
    mousex = love.mouse.getX()
    mousey = love.mouse.getY()

    if gamestate == "playing" and not paused and timeRunning then
        gameTime = gameTime + dt
    end

    if gamestate == "playing" and not paused then
        cameraX = cameraX + scrollSpeed * dt
        player.body:setX(225 + cameraX)

        if ball1:getX() + 400 < cameraX then
            ball1:setX(ball1:getX() + 1600)
        end

        if spike6:getX() + 400 < cameraX then
            spike6:setX(spike6:getX() + 1600)
        end
        if spike7:getX() + 400 < cameraX then
            spike7:setX(spike7:getX() + 1600)
        end
        if spike8:getX() + 400 < cameraX then
            spike8:setX(spike8:getX() + 1600)
        end
        if spike9:getX() + 400 < cameraX then
            spike9:setX(spike9:getX() + 1600)
        end

        if spike1:getX() + 400 < cameraX then
            spike1:setX(spike1:getX() + 1600)
        end
        if spike2:getX() + 400 < cameraX then
            spike2:setX(spike2:getX() + 1600)
        end
        if spike3:getX() + 400 < cameraX then
            spike3:setX(spike3:getX() + 1600)
        end
        if spike4:getX() + 400 < cameraX then
            spike4:setX(spike4:getX() + 1600)
        end
        if spike5:getX() + 400 < cameraX then
            spike5:setX(spike5:getX() + 1600)
        end

        if block1:getX() + 400 < cameraX then
            block1:setX(block1:getX() + 1600)
        end
        if block2:getX() + 400 < cameraX then
            block2:setX(block2:getX() + 1600)
        end
        if block3:getX() + 400 < cameraX then
            block3:setX(block3:getX() + 1600)
        end
        if block4:getX() + 400 < cameraX then
            block4:setX(block4:getX() + 1600)
        end

        if ground1:getX() + 400 < cameraX then
            ground1:setX(ground1:getX() + 1600)
        end
    
        if ground2:getX() + 400 < cameraX then
            ground2:setX(ground2:getX() + 1600)
        end
    end

    if paused then
        button_check()
    end

    if gamestate == "playing" then
        if not paused then
            if rotating then
                angle = angle + rotationSpeed * dt
                if angle >= math.pi then
                    angle = math.pi
                    rotating = false
                end
            end
            world:update(dt)
        end
    elseif gamestate == "menu" then
        buttons_check()
    elseif gamestate == "gameover" then
        buttonz_check()
    end
end

function love.draw()
    if gamestate == "playing" then
        love.graphics.clear(144 / 255, 202 / 255, 249 / 255)

        love.graphics.setFont(small)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("Time: %.2f", gameTime), 20, 20)
        love.graphics.print(string.format("Best: %.2f", bestTime), 20, 60)

        love.graphics.setFont(medium)

        love.graphics.push()
        love.graphics.translate(-cameraX, 0)

        love.graphics.setColor(21 / 255, 101 / 255, 192 / 255)
        local groundWidth = 800
        local startX = math.floor(cameraX / groundWidth) * groundWidth

        love.graphics.setColor(13 / 255, 71 / 255, 161 / 255)
        love.graphics.polygon("fill", ground1:getWorldPoints(groundShape:getPoints()))
        love.graphics.polygon("fill", ground2:getWorldPoints(groundShape:getPoints()))

        love.graphics.setColor(13 / 255, 71 / 255, 161 / 255)
        love.graphics.polygon("fill", block1:getWorldPoints(blockShape:getPoints()))
        love.graphics.polygon("fill", block2:getWorldPoints(blockShape1:getPoints()))
        love.graphics.polygon("fill", block3:getWorldPoints(blockShape2:getPoints()))
        love.graphics.polygon("fill", block4:getWorldPoints(blockShape2:getPoints()))

        love.graphics.setColor(198 / 255, 40 / 255, 40 / 255)
        love.graphics.polygon("fill", spike1:getWorldPoints(spikeShape:getPoints()))
        love.graphics.polygon("fill", spike2:getWorldPoints(spikeShape:getPoints()))
        love.graphics.polygon("fill", spike3:getWorldPoints(spikeShape:getPoints()))
        love.graphics.polygon("fill", spike4:getWorldPoints(spikeShape:getPoints()))
        love.graphics.polygon("fill", spike5:getWorldPoints(spikeShape:getPoints()))

        love.graphics.polygon("fill", spike6:getWorldPoints(spikeShape1:getPoints()))
        love.graphics.polygon("fill", spike7:getWorldPoints(spikeShape1:getPoints()))
        love.graphics.polygon("fill", spike8:getWorldPoints(spikeShape1:getPoints()))
        love.graphics.polygon("fill", spike9:getWorldPoints(spikeShape1:getPoints()))

        love.graphics.setColor(255, 238 / 255, 88 / 255)
        love.graphics.circle("fill", ball1:getX(), ball1:getY(), ballShape:getRadius())

        love.graphics.setColor(21 / 255, 101 / 255, 192 / 255)
        for i = -1, 2 do
         local x = startX + i * groundWidth
         love.graphics.rectangle("fill", x, 460, groundWidth, 40)
        end

        love.graphics.setColor(21 / 255, 101 / 255, 192 / 255)
        love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

        love.graphics.push()
        love.graphics.translate(player.body:getX(), player.body:getY())
        love.graphics.rotate(angle)
        love.graphics.setColor(255, 202 / 255, 40 / 255)
        love.graphics.polygon("fill", player.shape:getPoints())
        love.graphics.pop()

        if paused then
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", cameraX, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Game Paused", cameraX + 200, 50)
            love.graphics.print("Press ESC to Resume", cameraX + 125, 100)
            love.graphics.push()
            love.graphics.translate(cameraX, 0)
            button_draw()
            love.graphics.pop()
        end
        love.graphics.pop()
    elseif gamestate == "menu" then
        love.graphics.clear(144 / 255, 202 / 255, 249 / 255)
        love.graphics.setFont(medium)
        love.graphics.setColor(255, 202 / 255, 40 / 255)
        love.graphics.print("Geometry Dash But Lua", 80, 90)
        love.graphics.setFont(small)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("Best: %.2f", bestTime), 280, 145)
        buttons_draw()
    elseif gamestate == "gameover" then
        love.graphics.clear(144 / 255, 202 / 255, 249 / 255)
        love.graphics.setFont(medium)
        love.graphics.setColor(255, 202 / 255, 40 / 255)
        love.graphics.print("Game Over", 225, 90)
        love.graphics.setFont(small)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("Time: %.2f", gameTime), 275, 145)
        buttonz_draw()
    end
end

function love.keypressed(key)
    if gamestate == "playing" then
        if key == "escape" then
            paused = not paused
        end

        if not paused then
            local vx, vy = player.body:getLinearVelocity()

            if orbclick then
                if (key == "up" or key == "w" or key == "space") then
                    player.body:applyLinearImpulse(0, -200)
                    angle = 0
                    rotating = true
                    orbclick = false
                end
            elseif (key == "up" or key == "w" or key == "space") and math.abs(vy) < 0.1 then
                player.body:applyLinearImpulse(0, -200)
                angle = 0
                rotating = true
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if gamestate == "menu" then
        buttons_click(x, y)

        if gamestate == "playing" then
            gameTime = 0
            timeRunning = true
        end
    elseif gamestate == "gameover" then
        buttonz_click(x, y)
    elseif paused then
        button_click(x, y)
    end

    if gamestate == "playing" then
        local vx, vy = player.body:getLinearVelocity()

        if orbclick then
            if button == 1 then
                player.body:applyLinearImpulse(0, -200)
                angle = 0
                rotating = true
                orbclick = false
            end
        elseif button == 1 and math.abs(vy) < 0.1 then
            player.body:applyLinearImpulse(0, -200)
            angle = 0
            rotating = true
        end
    end
end


function beginContact(a, b, coll)
    if gamestate == "playing" then
        local ua, ub = a:getUserData(), b:getUserData()

        if (ua == "player" and ub == "spike") or (ua == "spike" and ub == "player") then
            gamestate = "gameover"
        end

        if (ua == "player" and ub == "block") or (ua == "block" and ub == "player") then
            gamestate = "gameover"
        end

        if (ua == "player" and ub == "ball") or (ua == "ball" and ub == "player") then
            orbclick = true
        end

        if (ua == "player" and ub == "spike") or (ua == "spike" and ub == "player")
        or (ua == "player" and ub == "block") or (ua == "block" and ub == "player") then
        gamestate = "gameover"

        if timeRunning then
         timeRunning = false
         if gameTime > bestTime then
             bestTime = gameTime
         end
    end
end
    end
end

function resetGame()
    cameraX = 0
    angle = 0
    rotating = false
    paused = false
    
    player.body:setPosition(225, 400)
    player.body:setLinearVelocity(0, 0)
    
    spike1:setX(540)
    spike2:setX(580)
    spike3:setX(780)
    spike4:setX(820)
    spike5:setX(860)
    spike6:setX(1690)
    spike7:setX(1730)
    spike8:setX(1770)
    spike9:setX(1810)

    block1:setX(1200)
    block2:setX(1400)
    block3:setX(1200)
    block4:setX(1400)

    ground1:setX(400)
    ground2:setX(1200)

    ball1:setX(1750)

    gameTime = 0
    timeRunning = true
end