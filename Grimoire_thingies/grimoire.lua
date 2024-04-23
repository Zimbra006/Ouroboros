--[[
    main file for the grimoire screen
    TODO:
    -- botoes para cada aba, e eles são atualizados aq
    -- cd página seria renderizada por cima do livro
]]

Grimoire = Class{}

require('Grimoire_thingies.Card_thingies.Deck')
require('Grimoire_thingies.Achievements_thingies.Achievements')
require('Grimoire_thingies.One_file_pages.Enemies')
require('Grimoire_thingies/One_file_pages/Recipes')
require('Grimoire_thingies/One_file_pages/Towers')

local DECK, ACHIEVEMENTS, ENEMIES, RECIPES, TOWERS = 0, 1, 2, 3, 4

function Grimoire:init()
    self.background = love.graphics.newImage('Graphics/Book&Titles/book.png')
    self.backBackground = love.graphics.newImage('Graphics/Details/tela_estatisticas.png')

    -- current state ofthe book
    self.book_state = RECIPES

    -- pages from the book
    self.deck_page = Deck()
    self.achievement_page = Achievements()
    self.enemies_page = Enemies()
    self.recipes_page = Recipes()
    self.towers_page = Towers()

    -- button to go back to the menu page
    self.return_button = Button({
        x = VIRTUAL_WIDTH - 90,
        y = -5,
        image = love.graphics.newImage('Graphics/Buttons/back.png'),
        OnClick = function() game_state = 'menu' end
    })

    self.marker = {
        image = love.graphics.newImage('Graphics/Details/lil_arrow.png'),
        x = VIRTUAL_WIDTH / 2 + 608,
        y = 95
    }

    -- buttons to change from page to page
    self.dividers = {}

    for i = 0, 4 do
        self.dividers[i + 1] = Button({
            x = VIRTUAL_WIDTH / 2 + 568 + 4 * i,
            y = 95 + 120 * i,
            width = 40,
            height = 80,
            OnClick = function() if self.book_state ~= i then self.book_state = i self.marker.x = VIRTUAL_WIDTH / 2 + 608 + 4 * i self.marker.y = 95 + 120 * i end end
        })
    end

end

function Grimoire:update(dt)

    self.return_button:update(dt)

    if self.book_state == DECK then
        self.deck_page:update(dt)
    elseif self.book_state == ACHIEVEMENTS then
        self.achievement_page:update(dt)
    elseif self.book_state == ENEMIES then
        self.enemies_page:update(dt)
    elseif self.book_state == RECIPES then
        self.recipes_page:update(dt)
    elseif self.book_state == TOWERS then
        self.towers_page:update(dt)
    end 

    for _, button in ipairs(self.dividers) do
        button:update(dt)
    end

end

function Grimoire:render()
    love.graphics.draw(self.backBackground)

    love.graphics.setColor(0, 0, 0, 0.3)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(self.background, 0, 35)

    self.return_button:render()

    love.graphics.draw(self.marker.image, self.marker.x, self.marker.y)

    love.graphics.setColor(0, 0, 0, 0.2)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 + 16, 35, 549, 617)

    if self.book_state ~= DECK then

        local pretty_thingy = love.graphics.newImage('Graphics/Details/pretty_thingy.png')
        local pretty_thingy_left = love.graphics.newImage('Graphics/Details/pretty_thingy_left.png')
        local line = love.graphics.newImage('Graphics/Details/line.png')
        local line_left = love.graphics.newImage('Graphics/Details/line_left.png')
        

        love.graphics.setColor(150, 150, 150, 1)
        love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 + 180, 170, 212, 212)
        love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 + 38, 443, 504, 184)

        for i = 1, 3 do
            love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 + 170 - i, 160 - i, 232 + i * 2, 232 + i * 2)
        end
        
        for i = 1, 3 do
            love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 + 25 + i, 430 + i, 530 - i * 2, 210 - i * 2)
        end
        
        love.graphics.setColor(1, 1, 1)

        love.graphics.draw(pretty_thingy, VIRTUAL_WIDTH / 2 + 417, 150)
        love.graphics.draw(pretty_thingy_left, VIRTUAL_WIDTH / 2 + 28, 150)
        love.graphics.draw(line, VIRTUAL_WIDTH / 2 + 440, 80)
        love.graphics.draw(line_left, VIRTUAL_WIDTH / 2 + 52, 80)
    end

    love.graphics.setColor(1, 1, 1)

    if self.book_state == DECK then
        self.deck_page:render()
    elseif self.book_state == ACHIEVEMENTS then
        self.achievement_page:render()
    elseif self.book_state == ENEMIES then
        self.enemies_page:render()
    elseif self.book_state == RECIPES then
        self.recipes_page:render()
    elseif self.book_state == TOWERS then
        self.towers_page:render()
    end
end