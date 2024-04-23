--[[
    File for choosing the deck that will modify gameplay
]]

Deck = Class{}

require('Grimoire_thingies.Card_thingies.card_stats')
require('Grimoire_thingies.Card_thingies.Card')

local cardsImages = {
    love.graphics.newImage('Graphics/Cards/slower_enemies.png'),
    love.graphics.newImage('Graphics/Cards/fiyaah.png'),
    love.graphics.newImage('Graphics/Cards/more_money.png'),
    love.graphics.newImage('Graphics/Cards/tower_discount.png'),
    love.graphics.newImage('Graphics/Cards/upgrade_discount.png'),
    love.graphics.newImage('Graphics/Cards/ready_made_tower.png'),
    love.graphics.newImage('Graphics/Cards/stronger_shot.png'),
    love.graphics.newImage('Graphics/Cards/faster_shot.png')
}

function Deck:init()
    self.title = language.deckTitle
    self.titleX = 150

    -- table for the current chosen cards
    self.deck = {'none', 'none', 'none'}

    -- table with all the avaiable cards
    self.cardsCollection = {}

    -- initializes all those cards
    for i = 0, #card_stats - 1 do
        local page = math.floor(i / 4) + 1
        if i % 4 == 0 then
            table.insert(self.cardsCollection, {})
        end
        local cardParams = card_stats[i + 1]
        cardParams.deck = self.deck
        cardParams.page = page
        cardParams.x = 190 + 250 * (math.floor((i % 4) / 2))
        cardParams.y = 155 + 248 * (i % 2)
        cardParams.image = cardsImages[i + 1]
        table.insert(self.cardsCollection[page], Card(cardParams))
    end

    -- sets the current page to whcih the player is looking
    self.cardsCollectionPage = 1

    -- button to go to the next cards page
    self.next_page_button = Button({
        x = VIRTUAL_WIDTH / 2 - 70,
        y = VIRTUAL_HEIGHT / 2 + 20,
        image = love.graphics.newImage('Graphics/Buttons/arrow_button.png'),
        OnClick = function() if self.cardsCollectionPage < #self.cardsCollection then self.cardsCollectionPage = self.cardsCollectionPage + 1 end end
    })

    -- button to go to the previous cards page
    self.previous_page_button = Button({
        x = VIRTUAL_WIDTH / 2 - 70,
        y = VIRTUAL_HEIGHT / 2 - 44,
        image = love.graphics.newImage('Graphics/Buttons/arrow_button_backwards.png'),
        OnClick = function() if self.cardsCollectionPage > 1 then self.cardsCollectionPage = self.cardsCollectionPage - 1 end end
    })
end

function Deck:update(dt)
    
    self.next_page_button:update(dt)
    self.previous_page_button:update(dt)
    for i, card in ipairs(self.cardsCollection[self.cardsCollectionPage]) do
        card:update(dt)
        if card.chosen then
            -- if the card is clicked (which makes it chosen), removes it from the cards table and move it to the deck table
            table.remove(self.cardsCollection[self.cardsCollectionPage], i)
        end
    end

    for i, card in ipairs(self.deck) do
        if card ~= 'none' then
            card:update(dt)
            if not card.chosen then
                -- if one of the chosencards has been clicked (making chosen false), puts it back into the card collection
                table.insert(self.cardsCollection[card.originalPage], card)
                table.remove(self.deck, i)
                table.insert(self.deck, 'none')
            end
        end
    end
end

function Deck:render()
    love.graphics.draw(self.title, self.titleX, 65)

    for i = -1, 1 do
        love.graphics.setColor(0, 0, 0, 0.4)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 + 230 + 90 * i, VIRTUAL_HEIGHT / 2 + 25 - 248 * math.abs(i), 150, 225)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.print((i + 2), VIRTUAL_WIDTH / 2 + 90 * i + 290, VIRTUAL_HEIGHT / 2 + 111 - 248 * math.abs(i), 0, 2)
    end
    love.graphics.setColor(1, 1, 1)

    if self.cardsCollectionPage < #self.cardsCollection then
        self.next_page_button:render()
    end

    if self.cardsCollectionPage > 1 then
        self.previous_page_button:render()
    end

    for _, card in ipairs(self.cardsCollection[self.cardsCollectionPage]) do
        card:render()
    end

    for _, card in ipairs(self.deck) do
        if card ~= 'none' then
            card:render()
        end
    end
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(language.yourDeck, VIRTUAL_WIDTH / 2 + 170, 65, 0, 2)
    love.graphics.setColor(1, 1, 1)
end