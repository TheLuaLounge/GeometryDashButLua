buttonz = {}

function buttonz_spawn(x, y, text, id)
    table.insert(buttonz, {x = x, y = y, text = text, id = id, mouseover = false})
end

function buttonz_draw()
    for i, v in ipairs(buttonz) do
        if v.mouseover then
            if v.id == "restart" then
                love.graphics.setColor(76 / 255, 175 / 255, 70 / 255)
            elseif v.id == "menuagain" then
                love.graphics.setColor(66 / 255, 165 / 255, 245 / 255)
            elseif v.id == "quit2" then
                love.graphics.setColor(239 / 255, 83 / 255, 80 / 255)
            end
        else
            love.graphics.setColor(255, 255, 255)
        end
        
        love.graphics.setFont(medium)
        love.graphics.print(v.text, v.x, v.y)
    end
end

function buttonz_click(x, y)
    for i, v in ipairs(buttonz) do
        if x > v.x and
        x < v.x + medium:getWidth(v.text) and
        y > v.y and
        y < v.y + medium:getHeight() then
            if v.id == "restart" then
                resetGame()
                gamestate = "playing"
            end
            if v.id == "menuagain" then
                gamestate = "menu"
            end
            if v.id == "quit2" then
                love.event.push("quit")
            end
        end
    end
end

function buttonz_check()
    for i, v in ipairs(buttonz) do
        if mousex > v.x and
        mousex < v.x + medium:getWidth(v.text) and
        mousey > v.y and
        mousey < v.y + medium:getHeight() then
            v.mouseover = true
        else
            v.mouseover = false
        end
    end
end