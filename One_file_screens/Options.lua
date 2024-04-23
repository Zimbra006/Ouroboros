--[[
    Options screen
]]

-- starts with the main language
language = english

Options = Class{s}

function Options:init()
    self.background = love.graphics.newImage('Graphics/Details/tela_estatisticas.png')

    -- button to change the language; restarting the other game screens to change them too
    self.change_language_button = Button({
        x = 50,
        y = VIRTUAL_HEIGHT - 100,
        width = 170,
        height = 50,
        OnClick = function() if language.metalanguage == 'English' then language = portuguese else language = english end menu_screen = Menu() death_screen = Death() grimoire_screen = Grimoire() updateStats() end
    })

    self.returnButton = Button({
        x = VIRTUAL_WIDTH - 125,
        y = 20,
        image = love.graphics.newImage('Graphics/Buttons/back.png'),
        OnClick = function() game_state = 'menu' end
    })
end

function Options:update(dt)
    self.change_language_button:update(dt)
    self.returnButton:update(dt)
end

function Options:render()
    love.graphics.draw(self.background)

    self.returnButton:render()

    love.graphics.print(language.language .. ':', 50, VIRTUAL_HEIGHT - 135)
    love.graphics.rectangle('line', 50, VIRTUAL_HEIGHT - 100, 170, 50)
    love.graphics.print(language.metalanguage, 55, VIRTUAL_HEIGHT - 90)

end