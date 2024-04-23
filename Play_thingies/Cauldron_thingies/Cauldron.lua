--[[
    File for the in-game boiling extravaganza
]]

Cauldron = Class{}

require('Play_thingies.Cauldron_thingies.recipes_table')

-- creates an inventory to store enemy drops
inventory = {
    {0, MAGIC_DUST},
    {0, INFERNAL_ICE},
    {0, GREAT_FLOWER},
    {0, DREAM_CRYSTAL},
    {0, DINOS_ESSENCE},
    {0, SNAKE_VENOM},
    {0, ORCS_EYE},
    {0, TREE_BRANCH}
}

function Cauldron:init(sidebar)
    self.chosenIngredients = {'none', 'none'}

    self.x = sidebar.width
    self.y = sidebar.y
    self.cauldron = love.graphics.newImage('Graphics/Details/caldeirao.png')

    self.recipesUnlocked = {}

    self.usedIngrediensAbundantia = false
    -- plus vita can only be used once per game
    self.usedPlusVita = false
    -- these ones can only be used 3 times per run
    self.usedWaviusDisaperius = 0
    self.usedMediumDisaperius = 0
    -- this is used to trigger the effect and the timer so it will run out
    self.doubleIngredients = false
    self.doubleIngredientsTimer = 11

    for _, recipe in ipairs(recipes) do
        if recipe.unlocked then
            table.insert(self.recipesUnlocked, recipe)
        end
    end

    self.nIngredients = #inventory

    self.ingredientsButtons = {}

    self.printRecipeWarning = false
    self.printNotEnoughWarning = false
    self.printIngredientsWarning = false
    self.alphaEffect = 1

    self.ingredientsImages = {
        love.graphics.newImage('Graphics/Ingredients/magicDust.png'),
        love.graphics.newImage('Graphics/Ingredients/infernalIce.png'),
        love.graphics.newImage('Graphics/Ingredients/greatFlower.png'),
        love.graphics.newImage('Graphics/Ingredients/dreamCrystal.png'),
        love.graphics.newImage('Graphics/Ingredients/dinosEssence.png'),
        love.graphics.newImage('Graphics/Ingredients/snakeVenom.png'),
        love.graphics.newImage('Graphics/Ingredients/orcseye.png'),
        love.graphics.newImage('Graphics/Ingredients/treeBranch.png')
    }

    for i = 1, self.nIngredients do
        self.ingredientsButtons[i] = Button({
            x = self.x - 282 - (101 * ((i - 1) % math.ceil(self.nIngredients / 2))),
            y = self.y + 11 + 69 * math.floor((i - 1) / math.ceil(self.nIngredients / 2)),
            width = 96,
            height = 64,
            OnClick = function()
                for j = 1, 2 do
                    if self.chosenIngredients[j] == 'none' and self.chosenIngredients[2] ~= inventory[i][2] then
                        self.chosenIngredients[j] = inventory[i][2]
                        break
                    elseif self.chosenIngredients[j] == inventory[i][2] then
                        self.chosenIngredients[j] = 'none'
                        break
                    end
                end
            end
        })
    end

    self.mishMashButton = Button({
        x = self.x - 170,
        y = self.y + 15,
        width = 128,
        height = 128,
        OnClick = function()
            
            local firstIngredient, secondIngredient = self.chosenIngredients[1], self.chosenIngredients[2]
            local effect = self:checkForRecipe(firstIngredient, secondIngredient)
            
            -- se a reação acontecer, aí tira os ingredientes (pra reações limitadas)

            if effect ~= 'none' and inventory[firstIngredient][1] > 0 and inventory[secondIngredient][1] > 0 then
                
                inventory[firstIngredient][1] = inventory[firstIngredient][1] - 1
                inventory[secondIngredient][1] = inventory[secondIngredient][1] - 1

                if effect == 'slowness' then
                    for _, enemy in ipairs(play_screen.enemies) do
                        enemy.state = 'slow'
                        enemy.stateTimer = -28
                    end
                elseif effect == 'poof' then
                    if self.usedWaviusDisaperius < 3 then
                        local nEnemies = #play_screen.enemies
                        for i = 1, nEnemies do
                            table.remove(play_screen.enemies)
                        end
                        self.usedWaviusDisaperius = self.usedWaviusDisaperius + 1
                    end
                elseif effect == 'disapear_three' then
                    for i = 0, 2 do
                        table.remove(play_screen.enemies, 1)
                    end
                elseif effect == 'stronger_shot' then
                    for _, tower in ipairs(play_screen.towers) do
                        if tower ~= 'none' then
                            tower.effect = 'stronger'
                        end
                    end
                elseif effect == 'next_jump' then

                elseif effect == 'meteor' then
                    local damage = 15 * (1 + (wave / 10) * (math.floor(wave / 15) + 1))
                    for _, enemy in ipairs(play_screen.enemies) do
                        enemy.health = enemy.health - damage
                    end
                elseif effect == 'abundance' then

                elseif effect == 'freeze' then
                    local nEnemies = #play_screen.enemies
                    for _, enemy in ipairs(play_screen.enemies) do
                        enemy.dx = 0
                        enemy.dy = 0
                        enemy.speed = 0
                    end
                elseif effect == 'poison' then
                    for i = 1, 3 do
                        table.remove(play_screen.enemies, i)
                    end
                elseif effect == 'seduction' then
                    local nEnemies = #play_screen.enemies
                    for i = 0, 2 do
                        if play_screen.enemies[nEnemies - i].damage ~= 0 then
                            play_screen.enemies[nEnemies - i].damage = 0
                        end
                    end
                elseif effect == 'next_weak' then

                elseif effect == 'boss_drops' then

                elseif effect == 'delay_wave' then
                    play_screen.spawnTimer = play_screen.spawnTimer + 5
                elseif effect == 'more_hearts' then
                    if not self.usedPlusVita then
                        global_health = global_health + 5
                        self.usedPlusVita = true
                    end
                elseif effect == 'more_ingredients' then

                elseif effect  == 'half_gone' then
                    if self.usedMediumDisaperius < 3 then
                        local nEnemies = #play_screen.enemies
                        for i = 1, nEnemies / 2 do
                            table.remove(play_screen.enemies)
                        end
                        self.usedMediumDisaperius = self.usedMediumDisaperius + 1
                    end
                elseif effect == 'money_end' then

                elseif effect == 'coins_per_kill' then

                elseif effect == 'half_waves' then

                elseif effect == 'one_hp' then
                    for _, enemy in ipairs(play_screen.enemies) do
                        enemy.health = 1
                    end
                elseif effect == 'short_waves' then

                elseif effect == 'faster_shot' then
                    for _, tower in ipairs(play_screen.towers) do
                        if tower ~= 'none' then
                            tower.effect = 'faster'
                        end
                    end
                elseif effect == 'less_per_kill' then

                elseif effect == 'double_ingredients' then
                    if self.doubleIngredientsTimer > 60 then
                        self.doubleIngredients = true
                    end
                elseif effect == 'plus_one_ingredients' then
                    if not self.usedIngrediensAbundantia then
                        for _, ingredient in ipairs(inventory) do
                            ingredient[1] = ingredient[1] + 1
                        end
                        self.usedIngrediensAbundantia = true
                    end
                elseif effect == 'freeze_timed' then
                    for _, enemy in ipairs(play_screen.enemies) do
                        enemy.state = 'slow'
                        enemy.stateTimer = -28
                    end
                elseif effect == 'boss_weak' then
                    
                elseif effect == 'money_times_money' then

                end

                self.chosenIngredients[1] = 'none'
                self.chosenIngredients[2] = 'none'
            elseif effect == 'none' and (firstIngredient == 'none' or secondIngredient == 'none') then
                self.printIngredientsWarning = true
            elseif effect == 'none' then
                self.printRecipeWarning = true
            elseif inventory[firstIngredient][1] == 0 or inventory[secondIngredient][1] == 0 then
                self.printNotEnoughWarning = true
            end
        end
    })
end

function Cauldron:checkForRecipe(ingredient1, ingredient2)
    local recipeFound = 'none'

    for _, recipe in ipairs(self.recipesUnlocked) do
        if (recipe.firstIngredient == ingredient1 or recipe.firstIngredient == ingredient2) and (recipe.secondIngredient == ingredient1 or recipe.secondIngredient == ingredient2) then
            recipeFound = recipe.effect
        end
    end

    return recipeFound
end

function Cauldron:update(dt)
    if self.printRecipeWarning or self.printNotEnoughWarning or self.printIngredientsWarning then
        self.alphaEffect = self.alphaEffect - 1 * dt
    end

    for _, button in ipairs(self.ingredientsButtons) do
        button:update(dt)
    end

    self.mishMashButton:update(dt)

    if self.doubleIngredients then
        for _, ingredient in ipairs(inventory) do
            ingredient[1] = ingredient[1] * 2
        end
        self.doubleIngredientsTimer = 0
        self.doubleIngredients = false
    end

    self.doubleIngredientsTimer = self.doubleIngredientsTimer + dt

    if self.doubleIngredientsTimer > 10 then
        for _, ingredient in ipairs(inventory) do
            ingredient[1] = math.floor(ingredient[1] / 2)
        end
    end
end

function Cauldron:render()
    love.graphics.draw(self.cauldron, self.x - 150, self.y + 15, 0, 2)

    local nIngredients = #inventory

    for i, ingredient in ipairs(inventory) do
        love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)
        love.graphics.rectangle('fill', self.x - 262 - (101 * ((i - 1) % math.ceil(nIngredients / 2))), self.y + 11 + 69 * math.floor((i - 1) / math.ceil(nIngredients / 2)), 96, 64)
        love.graphics.setColor(1, 1, 1)
        
        love.graphics.draw(self.ingredientsImages[i], self.x - 262 - (101 * ((i - 1) % math.ceil(nIngredients / 2))), self.y + 11 + 69 * math.floor((i - 1) / math.ceil(nIngredients / 2)), 0, 2)

        love.graphics.print(ingredient[1], self.x - 195 - (101 * ((i - 1) % math.ceil(nIngredients / 2))), self.y + 19 + 69 * math.floor((i - 1) / math.ceil(nIngredients / 2)), 0, 1.5)
    
        if self.chosenIngredients[1] == ingredient[2] or self.chosenIngredients[2] == ingredient[2] then
            love.graphics.setColor(9 / 255, 47 / 255 , 51 / 255, 1)
            love.graphics.rectangle('line', self.x - 262 - (101 * ((i - 1) % math.ceil(nIngredients / 2))), self.y + 11 + 69 * math.floor((i - 1) / math.ceil(nIngredients / 2)), 96, 64)
            love.graphics.rectangle('line', self.x - 261 - (101 * ((i - 1) % math.ceil(nIngredients / 2))), self.y + 12 + 69 * math.floor((i - 1) / math.ceil(nIngredients / 2)), 94, 62)
            love.graphics.setColor(1, 1, 1)
        end
    end

    if self.printRecipeWarning or self.printNotEnoughWarning or self.printIngredientsWarning then
        love.graphics.setColor(1, 1, 1, self.alphaEffect)
        if self.printRecipeWarning then
            love.graphics.print('No recipe found', mouse_x - 8 * 8, mouse_y - 24, 0, 1 / 2)
        elseif self.printNotEnoughWarning then
            love.graphics.print('Not enough ingredients', mouse_x - 8 * 8, mouse_y - 24, 0, 1 / 2)
        elseif self.printIngredientsWarning then
            love.graphics.print('Choose two ingredients', mouse_x - 8 * 8, mouse_y - 24, 0, 1 / 2)
        end
        love.graphics.setColor(1, 1, 1)
        if self.alphaEffect <= 0 then
            self.alphaEffect = 1
            self.printRecipeWarning = false
            self.printNotEnoughWarning = false
            self.printIngredientsWarning = false
        end
    end
end