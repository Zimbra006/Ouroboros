--[[
    The starting main screen
]]

Menu = Class{}

local rightImage = love.graphics.newImage('Graphics/Buttons/button_right.png')
local leftImage = love.graphics.newImage('Graphics/Buttons/button_left.png')

function Menu:init()
    -- creates images and buttons to populate the screen
    self.title = love.graphics.newImage('Graphics/Details/ouroboros.png')
    self.background = love.graphics.newImage('Graphics/Details/tela_principal.png')
    -- shows the currently held deck
    self.show_deck = false

    -- button to start playing, creates the play screen only when it's presed to account for changes, like the deck
    self.play_button = Button({
        x = VIRTUAL_WIDTH / 2 - 185,
        y = VIRTUAL_HEIGHT / 2 + 195,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        message = language.play,
        OnClick = function() play_screen = Play() game_state = 'play' end
    })
    -- goes to deck page
    self.grimoire_button = Button({
        x = 45,
        y = 240,
        image = love.graphics.newImage('Graphics/Buttons/book_icon.png'),
        OnClick = function() game_state = 'grimoire' end
    })
    -- goes tothe stats page
    self.stats_button = Button({
        x = 43,
        y = 100,
        image = love.graphics.newImage('Graphics/Buttons/stats.png'),
        OnClick = function() stats_screen = Stats() game_state = 'stats' end
    })
    -- goes to instructions page
    self.instruction_button = Button({
        x = 30,
        y = 30,
        image = love.graphics.newImage('Graphics/Buttons/question_mark.png'),
        OnClick = function() game_state = 'instructions' end
    })
    -- goes to the options page
    self.options_button = Button({
        x = 43,
        y = 170,
        image = love.graphics.newImage('Graphics/Buttons/config.png'),
        OnClick = function() game_state = 'options' end
    })
    -- shows the current held deck
    self.show_deck_button = Button({
        x = 0,
        y = 500,
        image = rightImage,
        OnClick = function() if self.show_deck then self.show_deck = false else self.show_deck = true end end
    })
    -- quiting the game
    self.quit_button = Button({
        x = VIRTUAL_WIDTH - 100,
        y = 30,
        image = love.graphics.newImage('Graphics/Buttons/quit_button.png'),
        OnClick = function() love.event.quit() end
    })
end

function Menu:update(dt)
    self.play_button:update(dt)
    self.instruction_button:update(dt)
    self.quit_button:update(dt)
    self.grimoire_button:update(dt)
    self.stats_button:update(dt)
    self.show_deck_button:update(dt)
    self.options_button:update(dt)

    if self.show_deck then
        self.show_deck_button.x = 220
        self.show_deck_button.image = leftImage
    else
        self.show_deck_button.x = 0
        self.show_deck_button.image = rightImage
    end
end

function Menu:render()
    love.graphics.draw(self.background, 0, 0)

    love.graphics.draw(self.title, VIRTUAL_WIDTH / 2 - self.title:getWidth() / 2, 70)
    self.play_button:render()
    self.instruction_button:render()
    self.quit_button:render()
    self.grimoire_button:render()
    self.stats_button:render()
    self.show_deck_button:render()
    self.options_button:render()

    if self.show_deck then
        love.graphics.setColor(20 / 255, 145 / 255, 54 / 255)
        love.graphics.rectangle('fill', 10, 400, 210, 300)
        love.graphics.setColor(1, 1, 1)
        for i, card in ipairs(grimoire_screen.deck_page.deck) do
            if card ~= 'none' then
                love.graphics.push()
                love.graphics.scale(0.5)
                love.graphics.translate(-790, 710)
                card:render()
                love.graphics.pop()
            else
                love.graphics.print('No card!', -7 + 27 * i + 31 * (i - 1), 640 - 170 * math.abs(i - 2), 0, 3 / 4)
            end
        end
    end
end