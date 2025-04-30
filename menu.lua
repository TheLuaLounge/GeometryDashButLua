buttons = {}

function buttons_spawn(x, y, text, id)
    table.insert(buttons, {x = x, y = y, text = text, id = id, mouseover = false})
end

function buttons_draw()
    for i, v in ipairs(buttons) do
        if v.mouseover then
            if v.id == "quit" then
                love.graphics.setColor(239 / 255, 83 / 255, 80 / 255)
            elseif v.id == "start" then
                love.graphics.setColor(76 / 255, 175 / 255, 70 / 255)
            end
        else
            love.graphics.setColor(255, 255, 255)
        end
        
        love.graphics.setFont(medium)
        love.graphics.print(v.text, v.x, v.y)
    end
end

function buttons_click(x, y)
    for i, v in ipairs(buttons) do
        if x > v.x and
        x < v.x + medium:getWidth(v.text) and
        y > v.y and
        y < v.y + medium:getHeight() then
            if v.id == "quit" then
                love.event.push("quit")
            end
            if v.id == "start" then
                resetGame()
                gamestate = "playing"
            end
        end
    end
end

function buttons_check()
    for i, v in ipairs(buttons) do
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