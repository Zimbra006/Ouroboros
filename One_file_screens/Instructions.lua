--[[
    Screen to explain how the game works
]]

Instructions = Class{}

function Instructions:init()
    self.background = love.graphics.newImage('Graphics/Details/tela_estatisticas.png')

    self.returnButton = Button({
        x = VIRTUAL_WIDTH - 125,
        y = 20,
        image = love.graphics.newImage('Graphics/Buttons/back.png'),
        OnClick = function() game_state = 'menu' end
    })
end

function Instructions:update(dt)
    self.returnButton:update(dt)
end

function Instructions:render()
    love.graphics.draw(self.background, 0, 0)
    self.returnButton:render()

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(language.instructions, 100, VIRTUAL_HEIGHT / 2 - 40, 0, 2)
    love.graphics.printf('- ' .. language.instructions1, 100, VIRTUAL_HEIGHT / 2 + 80, 760)
    love.graphics.printf('- ' .. language.instructions2, 100, VIRTUAL_HEIGHT / 2 + 180, 760)
    love.graphics.printf("- " .. language.instructions3, 100, VIRTUAL_HEIGHT / 2 + 280, 760)
    love.graphics.setColor(1, 1, 1)
end