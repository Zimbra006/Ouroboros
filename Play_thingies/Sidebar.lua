--[[
    File to the in-game menu for buying towers and cauldron thingies, etc
]]

Sidebar = Class{}

require('Play_thingies.Cauldron_thingies.Cauldron')
local upImage = love.graphics.newImage('Graphics/Buttons/button_up.png')
local downImage = love.graphics.newImage('Graphics/Buttons/button_down.png') 
local selectedBlockImg = love.graphics.newImage('Graphics/Details/selected_block.png')

function Sidebar:init()
    -- some stats related to towers
    totalTowersBought = 0
    towersBought = {
        -- basic
        0,
        -- sniper
        0,
        -- recaptain
        0,
        -- glass tower
        0,
        -- clamp
        0,
        -- magic light
        0,
        -- caged flower
        0,
        -- plasma beam
        0,
        -- tesla
        0,
        -- sauron
        0,
        -- cannon
        0,
        -- tank
        0
    }

    -- variable for damage giving
    damageDealt = 0
    damageByTowers = {
        -- basic
        0,
        -- sniper
        0,
        -- recaptain
        0,
        -- glass tower
        0,
        -- clamp
        0,
        -- magic light
        0,
        -- caged flower
        0,
        -- plasma beam
        0,
        -- tesla
        0,
        -- sauron
        0,
        -- cannon
        0,
        -- tank
        0
    }

    self.towerImages = {
        love.graphics.newImage('Graphics/Towers/basic.png'),
        love.graphics.newImage('Graphics/Towers/sniper.png'),
        love.graphics.newImage('Graphics/Towers/reCaptain.png'),
        love.graphics.newImage('Graphics/Towers/glassTower.png'),
        love.graphics.newImage('Graphics/Towers/clamp.png'),
        love.graphics.newImage('Graphics/Towers/magicLight.png'),
        love.graphics.newImage('Graphics/Towers/cagedFlower.png'),
        love.graphics.newImage('Graphics/Towers/plasmaBeam.png'),
        love.graphics.newImage('Graphics/Towers/tesla.png'),
        love.graphics.newImage('Graphics/Towers/sauron.png'),
        love.graphics.newImage('Graphics/Towers/cannon.png'),
        love.graphics.newImage('Graphics/Towers/tank.png')
    }

    -- the postion variables for the menu
    self.x, self.y = 0, VIRTUAL_HEIGHT * 8 / 10
    self.width, self.height = VIRTUAL_WIDTH, VIRTUAL_HEIGHT - self.y
    if language.metalanguage == 'English' then
        self.statsX = 300
    else
        self.statsX = 350
    end

    -- what block is selected, and its position; this is to display info on screen
    self.selectedBlock = {
        id = 'none',
        pos = 'none'
    }

    -- puts allthe currently unlocked towers here
    self.unlockedTowers = {}

    for _, tower in ipairs(tower_stats) do
        if tower.unlocked then
            table.insert(self.unlockedTowers, tower)
        end
    end

    -- what tower already on the map is selected
    self.selectedTower = 'none'

    -- the amount of towers so it shows the correct amount of buttons
    self.nTowers = #self.unlockedTowers

    -- what tower is selected now for purchase
    self.selectedTowerToBuy = 'none'

    -- to show the stats of the selected tower for purchase
    self.showTowerToBuyStats = false

    -- creates all the buttons related to selecting and buying the towers
    self.buyingTowersButtons = {}
    for i = 1, self.nTowers do
        self.buyingTowersButtons[i] = Button({
        x = 250 + (69 * ((i - 1) % math.ceil(self.nTowers / 2))),
        y =  self.y + 10 + 69 * math.floor((i - 1) / math.ceil(self.nTowers / 2)),
        width = 64,
        height = 64,
        OnClick = function() 
                if self.selectedTowerToBuy == i then 
                    if self:buy(i, self.selectedBlock.pos) then
                        self.selectedTower =  play_screen.towers[self.selectedBlock.pos.y][self.selectedBlock.pos.x]
                        self.selectedTower.showRange = true
                        self.selectedTowerToBuy = 'none'
                        self.selectedBlock = {
                            id = 'none',
                            pos = 'none'
                        }
                    end
                else 
                    self.selectedTowerToBuy = i 
                end 
            end
        })
    end

    -- boolean that's triggered when the player wnats to purchase more than he/she has
    self.printWarning = false
    -- makes the warning dissapear
    self.alphaEffect = 1

    -- button to show the stats of the tower that will (maybe) be bought
    self.show_stats_button = Button({
        x = 13,
        y = self.y - 22,
        image = downImage,
        OnClick = function() if self.selectedTowerToBuy ~= 'none' then if self.showTowerToBuyStats then self.showTowerToBuyStats = false else self.showTowerToBuyStats = true end end end
    })

    -- button to upgrade the selected tower
    self.upgrade_button = Button({
        x = 800,
        y = self.y + (self.height - 160) / 2,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        message = language.upgrade,
        OnClick = function() if self.selectedTower ~= 'none' then if self.selectedTower.upgradeTier < 5 then self:upgrade(self.selectedTower) end end end 
    })

    -- links cauldron to the sidebar
    self.cauldron = Cauldron(self)
end

function Sidebar:update(dt)
    -- if the player tried to buy something too expensive, the warning will have a nice fading effect
    if self.printWarning then
        self.alphaEffect = self.alphaEffect - 1 * dt
    end
    -- if a block where towers can be put is selected, update the button for showing the stats (which will only be shown now)
    if self.selectedBlock.id == SIDEWALK then

        self.show_stats_button:update(dt)

        for _, button in ipairs(self.buyingTowersButtons) do
            button:update(dt)
        end
        -- if it is showing the stats, updates the button's position so it's always on top
        if self.showTowerToBuyStats then
            self.show_stats_button.y = self.y - self.height - 22
            self.show_stats_button.image = downImage
        else
            self.show_stats_button.y = self.y - 22
            self.show_stats_button.image = upImage
        end
    elseif self.selectedTower ~= 'none' and self.selectedTower.upgradeTier < 5 then
        -- updates the button's message to show the price of upgrading
        self.upgrade_button.message = language.upgrade .. ' (' .. math.floor(self.selectedTower.upgradeCost * upgradePriceMultiplier) .. ')'
        self.upgrade_button:update(dt)
    end

    if self.selectedTower == 'none' then
        -- updates the cauldron
        self.cauldron:update(dt)
    end
end

-- a function to buy new towers, returns a boolean if bought or not (note: it will only be avaiable if the selected block is earth)
function Sidebar:buy(tower, position)
    local towerParams = self.unlockedTowers[self.selectedTowerToBuy]
    -- buys it if the mores money that the needed times the discount
    if global_money >= math.floor(towerParams.cost * towerPriceMultiplier) then
        global_money = global_money - math.floor(towerParams.cost * towerPriceMultiplier)
        -- adds a specific position and image (the image would lose quality if it was already on self.unlockedTowers) to the table
        towerParams.x = position.x
        towerParams.y = position.y
        towerParams.image = self.towerImages[self.selectedTowerToBuy]
        -- inserts a new array of bullets into the major array, so each tower can add and subtract bullets, but they will always be drawn after the towers
        local lastBulletTablePos = #play_screen.bullets + 1
        table.insert(play_screen.bullets, {})
        play_screen.towers[position.y][position.x] = Tower(towerParams, play_screen.enemies, play_screen.bullets[lastBulletTablePos])
        for i = 1, #towersBought do
            if towerParams.id == i then
                towersBought[i] = towersBought[i] + 1
            end
        end
        totalTowersBought = totalTowersBought + 1
        return true
    elseif global_money < math.floor(towerParams.cost * towerPriceMultiplier) then
        self.printWarning = true
        return false
    end
end

-- upgrades the towers, if there is more money than the needed times the discount
function Sidebar:upgrade(tower)
    if global_money >= math.floor(tower.upgradeCost * upgradePriceMultiplier) then
        global_money = global_money - math.floor(tower.upgradeCost * upgradePriceMultiplier)
        tower.upgraded = true
        tower.damage = math.floor(tower.damage * (1.4) * 10) / 10
        tower.range = math.floor(tower.range * (1.1) * 10) / 10
        tower.shootVel = math.floor(tower.shootVel * (1.09) * 10) / 10
        tower.delay = math.floor(tower.delay * (0.989) * 10) / 10
    else
        --print a warning for not enough money
        self.printWarning = true
    end
end

function Sidebar:render()
    -- shows the tower and its range before the purchase, if there's any tower selected
    if self.selectedTowerToBuy ~= 'none' and self.selectedBlock.id == SIDEWALK then
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.draw(self.towerImages[self.selectedTowerToBuy], (self.selectedBlock.pos.x - 1) * TILE_SIZE + (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2, (self.selectedBlock.pos.y - 1) * TILE_SIZE + (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2)
        for i = 1, 100 do
            love.graphics.setColor(26 / 255, 117 / 255 , 101 / 255, 0.5 - i / 100)
            love.graphics.circle('line', (self.selectedBlock.pos.x - 1) * TILE_SIZE + (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2 + 32, (self.selectedBlock.pos.y - 1) * TILE_SIZE + (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2 + 32, self.unlockedTowers[self.selectedTowerToBuy].range * TILE_SIZE + 32 - i)
            love.graphics.setColor(1, 1, 1)
        end
    end

    love.graphics.setColor(142 / 255, 72 / 255, 25 / 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)

    -- displays info of the selected block on screen
    if self.selectedBlock.id ~= 'none' and self.selectedBlock.id ~= EMPTY then
        love.graphics.draw(selectedBlockImg, (self.selectedBlock.pos.x - 1) * TILE_SIZE + (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2, (self.selectedBlock.pos.y - 1) * TILE_SIZE + (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2)
        love.graphics.print(language.blocks[self.selectedBlock.id - 1].name, 20, self.y + 20)
        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255)
        love.graphics.printf(language.blocks[self.selectedBlock.id - 1].desc, 20, self.y + 70, 230, 'left', 0, 0.75)
        love.graphics.setColor(1, 1, 1)
    end

    love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)

    love.graphics.line(240, self.y + 10, 240, self.y + self.height - 10)

    love.graphics.setColor(1, 1, 1)

    -- if the selected block is a plataform, displays towers available for purchase, as well as the stats of the selected one
    if self.selectedBlock.id == SIDEWALK then
        -- displays every tower avaiable to purchase in a small square, with a number for its cost
        local nButtons = #self.buyingTowersButtons
        for i = 1, nButtons do

            love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)
            love.graphics.rectangle('fill', 250 + (69 * ((i - 1) % math.ceil(self.nTowers / 2))), self.y + 11 + 69 * math.floor((i - 1) / math.ceil(self.nTowers / 2)), 64, 64)
            love.graphics.setColor(1, 1, 1)

            if i == self.selectedTowerToBuy then
                love.graphics.setColor(9 / 255, 47 / 255 , 51 / 255)
                love.graphics.rectangle('line', 250 + (69 * ((i - 1) % math.ceil(self.nTowers / 2))), self.y + 10 + 69 * math.floor((i - 1) / math.ceil(self.nTowers / 2)), 64, 64)
                love.graphics.setColor(1, 1, 1)
            end
            love.graphics.draw(self.towerImages[i], 250 + (69 * ((i - 1) % math.ceil(self.nTowers / 2))), self.y + 10 + 69 * math.floor((i - 1) / math.ceil(self.nTowers / 2)))
            -- print the cost of the tower, with the current discount
            love.graphics.print(math.floor(self.unlockedTowers[i].cost * towerPriceMultiplier), 289 + (69 * ((i - 1) % math.ceil(self.nTowers / 2))), self.y + 10 + 69 * math.floor((i - 1) / math.ceil(self.nTowers / 2)) + 48, 0, 0.75)
        end

        if self.selectedTowerToBuy ~= 'none' then
            -- render the button only if a tower is selected
            self.show_stats_button:render()

            -- displays the stats of the tower before the purchase
            if self.showTowerToBuyStats then
                love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)
                love.graphics.rectangle('fill', self.x, self.y - self.height, self.width, self.height)
    
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.towerImages[self.selectedTowerToBuy], 20, self.y + (-self.height - 128) / 2, 0, 2)
    
                love.graphics.setColor(142 / 255, 72 / 255, 25 / 255)
                love.graphics.rectangle('line', 20, self.y + (-self.height - 128) / 2, 128, 128)
    
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(self.unlockedTowers[self.selectedTowerToBuy].name, 160, self.y + (-self.height - 128) / 2)
                love.graphics.print(self.unlockedTowers[self.selectedTowerToBuy].desc, 400, self.y + (-self.height - 128) / 2, 0, 0.83)
    
                love.graphics.setColor(200 / 255, 200 / 255, 200 / 255)
                love.graphics.print(language.towerStatRange, 160, self.y + (-self.height - 128) / 2 + 30, 0, 0.83)
                love.graphics.print(language.towerStatDamage, 160, self.y + (-self.height - 128) / 2 + 80, 0, 0.83)
                love.graphics.print(language.towerStatShootVel, 400, self.y + (-self.height - 128) / 2 + 30, 0, 0.83)
                love.graphics.print(language.towerStatShootDelay, 400, self.y + (-self.height - 128) / 2 + 80, 0, 0.83)                
    
                love.graphics.setColor(20 / 255, 145 / 255, 54 / 255)
                love.graphics.rectangle('fill', 250, self.y + (-self.height - 128) / 2 + 30, self.unlockedTowers[self.selectedTowerToBuy].range * 10, 30)
                love.graphics.rectangle('fill', 250, self.y + (-self.height - 128) / 2 + 80, self.unlockedTowers[self.selectedTowerToBuy].damage * 10, 30)
                love.graphics.rectangle('fill', 250 + self.statsX, self.y + (-self.height - 128) / 2 + 30, self.unlockedTowers[self.selectedTowerToBuy].shootVel * 10, 30)
                love.graphics.rectangle('fill', 250 + self.statsX, self.y + (-self.height - 128) / 2 + 80, self.unlockedTowers[self.selectedTowerToBuy].delay * 20, 30)
    
                love.graphics.setColor(20 / 255, 117 / 255, 46 / 255)
                love.graphics.rectangle('line', 250, self.y + (-self.height - 128) / 2 + 30, 100, 30)
                love.graphics.rectangle('line', 250, self.y + (-self.height - 128) / 2 + 80, 100, 30)
                love.graphics.rectangle('line', 250 + self.statsX, self.y + (-self.height - 128) / 2 + 30, 100, 30)
                love.graphics.rectangle('line', 250 + self.statsX, self.y + (-self.height - 128) / 2 + 80, 100, 30)
                love.graphics.setColor(1, 1, 1)
            end
        end
    elseif self.selectedTower ~= 'none' then
        local tower = self.selectedTower
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.towerImages[tower.id], 56, self.y + (self.height - 128) / 2, 0, 2)

        love.graphics.setColor(1, 1, 1)
        love.graphics.print(tower.name, 252, self.y + (self.height - 128) / 2)

        love.graphics.setColor(200 / 255, 200 / 255, 200 / 255)
        love.graphics.print(language.towerStatRange, 252, self.y + (self.height - 128) / 2 + 30, 0, 0.83)
        love.graphics.print(language.towerStatDamage, 252, self.y + (self.height - 128) / 2 + 80, 0, 0.83)
        love.graphics.print(language.towerStatShootVel, 512, self.y + (self.height - 128) / 2 + 30, 0, 0.83)
        love.graphics.print(language.towerStatShootDelay, 512, self.y + (self.height - 128) / 2 + 80, 0, 0.83)
        love.graphics.print(self.unlockedTowers[tower.id].desc, 512, self.y + (self.height - 128) / 2, 0, 0.83)

        love.graphics.setColor(9 / 255, 47 / 255 , 51 / 255)
        love.graphics.print(self.selectedTower.range, 252 + string.len(language.towerStatRange) * 16 * 0.83 + 30, self.y + (self.height - 128) / 2 + 30)
        love.graphics.print(self.selectedTower.damage, 252 + string.len(language.towerStatDamage) * 16 * 0.83 + 30, self.y + (self.height - 128) / 2 + 80)
        love.graphics.print(self.selectedTower.shootVel, 512 + string.len(language.towerStatShootVel) * 16 * 0.83 + 30, self.y + (self.height - 128) / 2 + 30)
        love.graphics.print(self.selectedTower.delay, 512 + string.len(language.towerStatShootDelay) * 16 * 0.83 + 30, self.y + (self.height - 128) / 2 + 80)

        love.graphics.setColor(1, 1, 1)
        if self.selectedTower.upgradeTier < 5 then
            self.upgrade_button:render()
        end
    end

    -- if the player doesn't have enough money, says it with a fading effect
    if self.printWarning then
        love.graphics.setColor(1, 1, 1, self.alphaEffect)
        love.graphics.print(language.notEnoughMoney, mouse_x - 8 * 8, mouse_y - 24, 0, 1 / 2)
        love.graphics.setColor(1, 1, 1)
        if self.alphaEffect <= 0 then
            self.alphaEffect = 1
            self.printWarning = false
        end
    end

    if self.selectedTower == 'none' then
        -- halves the sidebar
        love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)

        love.graphics.line(self.width / 2, self.y + 10, self.width / 2, self.y + self.height - 10)
    end
    love.graphics.setColor(1, 1, 1)

    if self.selectedTower == 'none' then
        --renders the cauldron
        self.cauldron:render()
    end
end