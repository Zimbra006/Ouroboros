--[[
    File to deal with anything related to the gaeplay
]]

Play = Class{}

require('Play_thingies.Map_thingies.Map')
require('Play_thingies.Objectives')
require('Play_thingies.Tower_thingies.tower_stats')
require('Play_thingies.Sidebar')
require('Play_thingies.Enemy_thingies.Waves')
require('Play_thingies.Tower_thingies.tower')

function Play:init()
    self.background = love.graphics.newImage('Graphics/Details/tela_jogo.png')

    -- global variable to know the current wave, with 0 being the first
    wave = 0

    -- global variable to show the current base health
    global_health = 25
    
    -- global variable for money $$
    global_money = 138

    -- little simbols for time to next wave, health and money
    self.clock = love.graphics.newImage("Graphics/Details/clock.png")
    self.heart = love.graphics.newImage('Graphics/Details/heart.png')
    self.coin = love.graphics.newImage('Graphics/Details/coin.png')
    
    -- loads the map
    self.map = Map()

    -- loads the menu from which to buy the towers
    self.sidebar = Sidebar()

    -- loads the objectives mechanic
    self.objective = Objectives()

    -- an array to store the towers on screen
    self.towers = {}
    for i = 1, self.map.mapHeight do
        self.towers[i] = {}
        for j = 1, self.map.mapWidth do
            self.towers[i][j] = 'none'
        end
    end

    -- array for on screen bullets, so they can be draw on top of the towers
    self.bullets = {}

    -- array for the enemies, to deal with them on a broad perspective
    self.enemies = {}

    -- initializes the starting wave of enemies
    self.wave = Waves({
        map = self.map,
        enemyTable = self.enemies,
        enemyAmount = 5,
        enemyType = ELF,
        spawnTime = 1
    })

    -- timer to show for how long the player is playing
    self.timer = 0
    -- stopwatch until the next wave spawn
    self.spawnTimer = 30

    -- some buttons
    self.pause_button = Button({
        x = VIRTUAL_WIDTH - 50,
        y = 10,
        image = love.graphics.newImage('Graphics/Buttons/pause_button.png'),
        OnClick = function() game_state = 'pause' end
    })
    -- these two only show when the game is paused, one resumer the game and the other quits it
    self.resume_button = Button({
        x = VIRTUAL_WIDTH / 2 - 320,
        y = VIRTUAL_HEIGHT / 2 + 20,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        message = language.resume,
        OnClick = function() game_state = 'play' end
    })
    self.menu_button = Button({
        x = VIRTUAL_WIDTH / 2 - 20,
        y = VIRTUAL_HEIGHT / 2 + 20,
        image = love.graphics.newImage('Graphics/Buttons/button.png'),
        message = language.menu,
        OnClick = function() updateProgress() grimoire_screen.achievement_page:tableUpdate() grimoire_screen.towers_page:checkForUnlockeds() game_state = 'menu' play_screen = Play() end
    })

    -- this code is for when the card that allows the player to have 2 randomly placed basic towers is active
    -- it only checks anything that isn't close to the edge of the map
    if startingTowers > 0 then
        local towersLeft = startingTowers
        local basicTowerParams = tower_stats[BASIC]
        local basicImage = love.graphics.newImage('Graphics/Towers/basic.png')
        for y = 2, self.map.mapHeight - 1 do
            for x = 2, self.map.mapWidth - 1 do
                if self.map.map[y][x] == SIDEWALK then
                    if self.map.map[y][x + 1] == ROAD or self.map.map[y][x - 1] == ROAD or self.map.map[y + 1][x] == ROAD or self.map.map[y - 1][x] == ROAD then
                        if (math.random(1, 10) < 7 and towersLeft > 0) or (y > 6 and x > 14 and towersLeft > 0) then
                            basicTowerParams.x = x
                            basicTowerParams.y = y
                            basicTowerParams.image = basicImage
                            local lastBulletTablePos = #self.bullets + 1
                            table.insert(self.bullets, {})
                            self.towers[y][x] = Tower(basicTowerParams, self.enemies, self.bullets[lastBulletTablePos])
                            towersLeft = towersLeft - 1
                        end
                    end
                end
            end
        end
    end
end

function Play:update(dt)
    if game_state == 'play' then
        -- updates both timers
        self.spawnTimer = self.spawnTimer - dt
        self.timer = self.timer + dt

        for i, enemy in ipairs(self.enemies) do
            enemy:update(dt)
            -- gets rid of dead or victorious enemies
            if enemy.health <= 0 or enemy.foundBase then
                if enemy.health <= 0 then -- if enemy was actually killed
                    -- updates objectives related to enemy killing
                    if enemy.type == ELF then
                        killed_elfs = killed_elfs + 1
                    elseif enemy.type == IMP then
                        killed_imps = killed_imps + 1
                    elseif enemy.type == GENIE then
                        killed_genies = killed_genies + 1
                    elseif enemy.type == LAND_MAN then
                        killed_land_men = killed_land_men + 1
                    elseif enemy.type == DINO then
                        killed_dinos = killed_dinos + 1
                    elseif enemy.type == BOITATA then
                        killed_boitatas = killed_boitatas + 1
                    elseif enemy.type == CENTAUR then
                        killed_centaurs = killed_centaurs + 1
                    elseif enemy.type == MEDUSA then
                        killed_medusas = killed_medusas + 1
                    elseif enemy.type == OLD_SAGE then
                        killed_old_sages = killed_old_sages + 1
                    elseif enemy.type == WITCH then
                        killed_witches = killed_witches + 1
                    elseif enemy.type == ORC then
                        killed_orcs = killed_orcs + 1
                    elseif enemy.type == HEADLESS_MULE then
                        killed_headless_mules = killed_headless_mules + 1
                    elseif enemy.type == BLACK_GOAT then
                        killed_black_goats = killed_black_goats + 1
                    elseif enemy.type == OUROBOROS then
                        killed_ouroboros = killed_ouroboros + 1
                    end
                    killed_enemies = killed_enemies + 1
                    -- gives a random amount of money as reward, times the current money multiplier
                    global_money = global_money + math.floor(math.random(2, 6) * moneyMultiplier)
                
                    if math.random(1, 3) == 1 then
                        local nIngredients = #inventory
                        local firstIngredient = math.random(nIngredients)
                        for i = 0, nIngredients - 1 do
                            local currentIngredient = (firstIngredient + 7 * i) % nIngredients + 1
                            if inventory[currentIngredient][1] < 9 then
                                inventory[currentIngredient][1] = inventory[currentIngredient][1] + 1
                                break
                            end
                        end
                    end
                end
                table.remove(self.enemies, i)
            end
        end

        -- updates the current wave, so it can periodically spawn
        self.wave:update(dt)

        -- updates every tower inside the array
        for _, row in ipairs(self.towers) do
            for _, tower in ipairs(row) do
                if tower ~= 'none' then
                    tower:update(dt)
                end
            end
        end

        -- once the spawnTimer goes down, or it doesn't have any enemies anymore, spawns the next wave
        if self.spawnTimer <= 0 or #self.enemies <= 0 then
            self:spawnWaves()
        end

        -- if the mouse was clicked, hides the range of the selected tower, if any, and if it's inside the map, selects a block or a tower to display
        if mouseWasClicked then
            for _, row in ipairs(self.towers) do
                for _, tower in ipairs(row) do
                    if tower ~= 'none' then
                        tower.showRange = false
                    end
                end
            end
            if mouse_x > self.map.x and mouse_x < self.map.x + self.map.widthPixels and mouse_y > self.map.y and mouse_y < self.map.y + self.map.heightPixels then
                self:mapClick()
            end
        end

        -- when the player dies, go to the death screen
        if global_health <= 0 then
            updateProgress()
            grimoire_screen.achievement_page:tableUpdate()
            grimoire_screen.towers_page:checkForUnlockeds()
            game_state = 'game over'
        end
        
        self.pause_button:update(dt)
        
        -- updates the other major entities
        self.sidebar:update(dt)
        self.objective:update()
    elseif game_state == 'pause' then
        self.resume_button:update(dt)
        self.menu_button:update(dt)
    end
end 

-- when a block or tower from the map is clicked, identifies it and sends it to the tower menu
function Play:mapClick()
    local clickPos = {
        x = math.ceil((mouse_x - (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2) / TILE_SIZE),
        y = math.ceil((mouse_y - (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2) / TILE_SIZE)
    }
    
    if self.towers[clickPos.y][clickPos.x] ~= 'none' then
        self.sidebar.selectedBlock = {id = 'none', pos = 'none'}
        self.towers[clickPos.y][clickPos.x].showRange = true
        self.sidebar.selectedTowerToBuy = 'none'
        self.sidebar.selectedTower = self.towers[clickPos.y][clickPos.x]
    else
        self.sidebar.selectedTower = 'none'
        local clickBlock = self.map.map[clickPos.y][clickPos.x]
        self.sidebar.selectedBlock = {id = clickBlock, pos = clickPos}
        if clickBlock ~= SIDEWALK then
            self.sidebar.selectedTowerToBuy = 'none'
        end
    end
end

local enemies = {}
-- self explanatory function
function Play:spawnWaves()
    -- a table with all the possible enemies to be spawned
    local numberOfWave = wave % 50

    if numberOfWave < 19 then
        enemies = {ELF, IMP, GENIE, LAND_MAN, BOITATA}
    elseif numberOfWave > 19 then
        enemies = {CENTAUR, MEDUSA, OLD_SAGE, WITCH, ORC}
    end

    -- adds a new enemy at wave 8
    if numberOfWave > 7 and numberOfWave < 19 then
        table.insert(enemies, DINO)
    end

    -- removes the weakest enemy at wave 12
    if numberOfWave > 11 and numberOfWave < 19 then
        table.remove(enemies, 1)
    end

    -- removes the weakest enemy again, at wave 16
    if numberOfWave > 15 and numberOfWave < 19 then
        table.remove(enemies, 1)
        table.insert(enemies, CENTAUR)
    end

    -- boss waves at wave 20, 40 and 50
    if numberOfWave == 19 then
        enemies = {HEADLESS_MULE}
    elseif numberOfWave == 39 then
        enemies = {BLACK_GOAT}
    elseif numberOfWave == 49 then
        enemies = {OUROBOROS}
    end

    -- chooses the type of enemy to be spawned, how many of them and how much time between each enemy
    local toBeEnemy = enemies[math.random(#enemies)]
    local toBeAmount = math.random(3, 10)
    local toBeSpawnTime = math.random(5, 10) / 10
    
    -- sets some retrictions so it doesn't have much tough enemies, neither many fast enemie with little space between them
    if toBeEnemy == DINO and toBeAmount >= 6 then
        toBeAmount = 6
    end

    if numberOfWave == 19 or numberOfWave == 39 or numberOfWave == 49 then
        toBeAmount = 1
    end

    -- resets this effect once a new wave is spawned
    self.sidebar.cauldron.usedIngrediensAbundantia = false

    -- updates the number of spawned waves
    wave = wave + 1
    -- resets the timer
    self.spawnTimer = 30
    -- spawns the next wave
    self.wave = Waves({
        map = self.map,
        enemyTable = self.enemies,
        enemyAmount = toBeAmount,
        enemyType = toBeEnemy,
        spawnTime = toBeSpawnTime
    })
end

-- draws everything
function Play:render()
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.draw(self.background)
    love.graphics.setColor(1, 1, 1, 1) 

    self.map:render()
    
    for _, enemy in ipairs(self.enemies) do
        enemy:render()
    end

    for _, row in ipairs(self.towers) do
        for _, tower in ipairs(row) do
            if tower ~= 'none' then
                tower:render()
            end
        end
    end

    for _, row in ipairs(self.bullets) do
        for _, bullet in ipairs(row) do
            bullet:render()
        end
    end

    -- draws the other major entities
    self.sidebar:render()
    self.objective:render()
    
    self.pause_button:render()

    -- draws the simbols next to their stats
    love.graphics.draw(self.heart, 10, 10)
    love.graphics.print(global_health, 54, 14)
    love.graphics.draw(self.clock, 120, 10)
    love.graphics.print(math.ceil(self.spawnTimer), 164, 14)
    love.graphics.draw(self.coin, 230, 10)
    love.graphics.print(global_money, 274, 14)
    love.graphics.print(math.floor(self.timer / 60) .. ':' .. math.floor(self.timer % 60), VIRTUAL_WIDTH / 2 - 50, 10)

    if game_state == 'pause' then
        -- shadows the entire background nicely
        love.graphics.setColor(0, 0, 0, 0.35)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        
        -- draws the pop up, with some lines to detail it
        love.graphics.setColor(20 / 255, 108 / 255 , 117 / 255)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 345, VIRTUAL_HEIGHT / 2 - 150, 680, 300)
        love.graphics.setColor(9 / 255, 47 / 255 , 51 / 255, 1)
        love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 - 342, VIRTUAL_HEIGHT / 2 - 148, 674, 296)
        love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 - 341, VIRTUAL_HEIGHT / 2 - 147, 672, 294)
        love.graphics.rectangle('line', VIRTUAL_WIDTH / 2 - 340, VIRTUAL_HEIGHT / 2 - 146, 670, 292)
        love.graphics.line(VIRTUAL_WIDTH / 2 - 4.7 * 32, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH / 2 + 4 * 32, VIRTUAL_HEIGHT / 2 - 40)
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(language.pause, VIRTUAL_WIDTH / 2 - 3.6 * 32, VIRTUAL_HEIGHT / 2 - 100, 0, 2)
        self.resume_button:render()
        self.menu_button:render()
    end
end
    
