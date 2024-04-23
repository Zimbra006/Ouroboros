--[[
    File for the essence of a card
]]

Card = Class{}

function Card:init(params)
    -- links card and the current chosen cards, aka the deck
    self.deck = params.deck
    self.x = params.x
    self.y = params.y
    -- where to put them back if they are discarded
    self.originalPage = params.page
    self.originalX = params.x
    self.originalY = params.y
    -- standard card width and height
    self.width = 150
    self.height = 225
    -- text to be displayed
    self.message = params.message
    -- card image
    self.image = params.image

    -- estabilishes a relationship between this card and its modifier inside he table of effects in Deck.lua
    self.effect = params.effect or function() end
    -- counter-effect to reset the modifier
    self.reset = params.reset or function() end

    -- the card will know once it gets chosen, and will activate its effect
    self.chosen = false
end

function Card:update(dt)
    if self.chosen then
        -- if the card has been clicked when chosen, returns to its original position
        if mouse_x > self.x and mouse_x < self.x + self.width and mouse_y > self.y and mouse_y < self.y + self.height and mouseWasClicked then
            self.chosen = false
            self.x = self.originalX
            self.y = self.originalY
            self.reset()
        end
    else
        if mouse_x > self.x and mouse_x < self.x + self.width and mouse_y > self.y and mouse_y < self.y + self.height and mouseWasClicked then
            -- if the card has been clicked when not chosen, finds the next avaiable spot on deck, if any
            for i, card in ipairs(self.deck) do
                local newX = VIRTUAL_WIDTH / 2 + 230 + 90 * (i - 2)
                local newY = VIRTUAL_HEIGHT / 2 + 25 - 248 * math.abs(i - 2)
                if card == 'none' then
                    self.deck[i] = self
                    self.x = newX
                    self.y = newY
                    self.chosen = true
                    self.effect()
                    break
                end
            end
        end
    end
end

function Card:render()
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.message, self.x + 33, self.y + self.height - 40, self.width + 80, 'left', 0, 5 / 8)
    love.graphics.setColor(1, 1, 1)
end