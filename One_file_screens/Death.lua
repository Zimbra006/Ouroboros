--[[
    Simple file for the game over screen
]]

Death = Class{}

function Death:init()
    -- gets the game over image
    self.death_sentence = language.deathSentence

    -- creates the button to go back to the menu screen
    self.menuButton = Button({
        x = VIRTUAL_WIDTH / 2 - 380,
        y = VIRTUAL_HEIGHT / 2 + self.death_sentence:getHeight() / 2 + 80,
        message = language.menu,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        OnClick = function() game_state = 'menu' end
    })
    -- button to restart the game, with a new map
    self.restartButton = Button({
        x = VIRTUAL_WIDTH / 2 + 10,
        y = VIRTUAL_HEIGHT / 2 + self.death_sentence:getHeight() / 2 + 80,
        message = language.restart,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        OnClick = function() play_screen = Play() game_state = 'play' end
    })
end

function Death:update(dt)
    self.menuButton:update(dt)
    self.restartButton:update(dt)
end

function Death:render()
    love.graphics.draw(self.death_sentence, VIRTUAL_WIDTH / 2 - self.death_sentence:getWidth() / 2, VIRTUAL_HEIGHT / 2 - self.death_sentence:getHeight() / 2)
    self.menuButton:render()
    self.restartButton:render()
end