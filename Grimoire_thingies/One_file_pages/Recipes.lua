--[[
    file to catalogue the recipes
]]

Recipes = Class{}

local parchments = {
    love.graphics.newImage('Graphics/Pergaminhos/waviusDisapearius.png'),
    love.graphics.newImage('Graphics/Pergaminhos/triusDisaperius.png'),
    love.graphics.newImage('Graphics/Pergaminhos/tirusFortius.png'),
    love.graphics.newImage('Graphics/Pergaminhos/deindePreocuppo.png'),
    love.graphics.newImage('Graphics/Pergaminhos/meteorum.png'),
    love.graphics.newImage('Graphics/Pergaminhos/abundantia.png'),
    love.graphics.newImage('Graphics/Pergaminhos/glacies.png'),
    love.graphics.newImage('Graphics/Pergaminhos/venenum.png'),
    love.graphics.newImage('Graphics/Pergaminhos/fascinare.png'),
    love.graphics.newImage('Graphics/Pergaminhos/deindeInfirma.png'),
    love.graphics.newImage('Graphics/Pergaminhos/fortisIngrediens.png'),
    love.graphics.newImage('Graphics/Pergaminhos/waviusDemorus.png'),
    love.graphics.newImage('Graphics/Pergaminhos/plusVita.png'),
    love.graphics.newImage('Graphics/Pergaminhos/plusIngrediens.png'),
    love.graphics.newImage('Graphics/Pergaminhos/mediumDisaperius.png'),
    love.graphics.newImage('Graphics/Pergaminhos/pecunia.png'),
    love.graphics.newImage('Graphics/Pergaminhos/mortemAbundantia.png'),
    love.graphics.newImage('Graphics/Pergaminhos/waviusMediums.png'),
    love.graphics.newImage('Graphics/Pergaminhos/waviusInfirma.png'),
    love.graphics.newImage('Graphics/Pergaminhos/tarda.png'),
    love.graphics.newImage('Graphics/Pergaminhos/waviusCurtis.png'),
    love.graphics.newImage('Graphics/Pergaminhos/tirusRapidus.png'),
    love.graphics.newImage('Graphics/Pergaminhos/mortemShorten.png'),
    love.graphics.newImage('Graphics/Pergaminhos/geminusIngrediens.png'),
    love.graphics.newImage('Graphics/Pergaminhos/ingrediensAbundantia.png'),
    love.graphics.newImage('Graphics/Pergaminhos/glaciesCurtis.png'),
    love.graphics.newImage('Graphics/Pergaminhos/fortisInfirma.png'),
    love.graphics.newImage('Graphics/Pergaminhos/plusPecunia.png')
}

function Recipes:init()
    self:checkForUnlockeds()

    self.title = language.recipesTitle
    self.titleX = 140

    self.pages = {}
    self.buttonPages = {}
    self.page = 1

    self.recipeDisplayed = 'none'

    for i, recipe in ipairs(recipes) do
        if (i - 1) % 8 == 0 then
            table.insert(self.pages, {})
            table.insert(self.buttonPages, {})
        end

        local page = math.floor((i - 1) / 8) + 1

        recipe.image = parchments[i]

        table.insert(self.pages[page], recipe)

        table.insert(self.buttonPages[page], Button({
            x = 130,
            y = 170 + 60 * ((i - 1) % 8),
            width = 480,
            height = 50,
            OnClick = function() self.recipeDisplayed = recipe end
        }))
    end

    -- button to go to the next cards page
    self.next_page_button = Button({
        x = VIRTUAL_WIDTH / 2 - 70,
        y = VIRTUAL_HEIGHT / 2 + 20,
        image = love.graphics.newImage('Graphics/Buttons/arrow_button.png'),
        OnClick = function() if self.page < #self.pages then self.page = self.page + 1 end end
    })

    -- button to go to the previous cards page
    self.previous_page_button = Button({
        x = VIRTUAL_WIDTH / 2 - 70,
        y = VIRTUAL_HEIGHT / 2 - 44,
        image = love.graphics.newImage('Graphics/Buttons/arrow_button_backwards.png'),
        OnClick = function() if self.page > 1 then self.page = self.page - 1 end end
    })
end

function Recipes:update(dt)
    self.next_page_button:update(dt)
    self.previous_page_button:update(dt)
    for _, button in ipairs(self.buttonPages[self.page]) do
        button:update(dt)
    end
end

function Recipes:render()
    love.graphics.draw(self.title, self.titleX, 65)

    if self.page < #self.pages then
        self.next_page_button:render()
    end

    if self.page > 1 then
        self.previous_page_button:render()
    end

    for i, recipe in ipairs(self.pages[self.page]) do
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 130, 170 + 60 * (i - 1), 480, 50)
        love.graphics.setColor(0, 0, 0)

        if not recipe.unlocked then
            love.graphics.print('????????', 180, 180 + 60 * (i - 1))
            love.graphics.draw(recipe.image, 140, 180 + 60 * (i - 1), 0, 1 / 2)
        else
            love.graphics.print(recipe.effectName, 180, 180 + 60 * (i - 1))
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(recipe.image, 140, 180 + 60 * (i - 1), 0, 1 / 2)
        end
    end

    if self.recipeDisplayed ~= 'none' then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(language.ingredients, VIRTUAL_WIDTH / 2 + 50, 460)
        love.graphics.print(language.effect, VIRTUAL_WIDTH / 2 + 250, 460)

        if self.recipeDisplayed.unlocked then
            love.graphics.setColor(0, 0, 0)
            if string.len(self.recipeDisplayed.effectName) > 10 then
                love.graphics.printf(self.recipeDisplayed.effectName, VIRTUAL_WIDTH / 2 + 166, 55, 150, "center", 0, 3 / 2)
            else
                love.graphics.printf(self.recipeDisplayed.effectName, VIRTUAL_WIDTH / 2 + 116, 65, 170, "center", 0, 2)
            end
            love.graphics.print('-' .. self.recipeDisplayed.firstIngredientName, VIRTUAL_WIDTH / 2 + 50, 510)
            love.graphics.print('-' .. self.recipeDisplayed.secondIngredientName, VIRTUAL_WIDTH / 2 + 50, 560)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.recipeDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
        else
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf('????????', VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.draw(self.recipeDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
            for i = 1, 2 do
                love.graphics.print('-?????', VIRTUAL_WIDTH / 2 + 50, 460 + 50 * i)
            end
            love.graphics.printf('-??????????????', VIRTUAL_WIDTH / 2 + 250, 510, 252)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function Recipes:checkForUnlockeds()
    for i, recipe in ipairs(recipes) do
        if not recipe.unlocked then
            if achievements.recipes[i].made then
                recipe.unlocked = true
            end
        end
    end
end