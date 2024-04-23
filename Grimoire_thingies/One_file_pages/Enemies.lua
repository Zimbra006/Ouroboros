--[[
    file to catalogue the enemies inside the grimoire
]]

Enemies = Class{}

function Enemies:init()
    self:checkForKills()

    self.title = language.enemiesTitle
    self.titleX = 125

    self.pages = {}
    self.buttonPages = {}
    self.page = 1

    self.enemiesImages = {
        love.graphics.newImage('Graphics/Enemies/elf.png'),
        love.graphics.newImage('Graphics/Enemies/imp.png'),
        love.graphics.newImage('Graphics/Enemies/genie.png'),
        love.graphics.newImage('Graphics/Enemies/land_man.png'),
        love.graphics.newImage('Graphics/Enemies/barney.png'),
        love.graphics.newImage('Graphics/Enemies/boitata.png'),
        love.graphics.newImage('Graphics/Enemies/centaur.png'),
        love.graphics.newImage('Graphics/Enemies/medusa.png'),
        love.graphics.newImage('Graphics/Enemies/old_sage.png'),
        love.graphics.newImage('Graphics/Enemies/witch.png'),
        love.graphics.newImage('Graphics/Enemies/orc.png'),
        love.graphics.newImage('Graphics/Enemies/headless_mule.png'),
        love.graphics.newImage('Graphics/Enemies/black_goat.png'),
        love.graphics.newImage('Graphics/Enemies/ouroboros.png')
    }

    self.enemyDisplayed = 'none'

    for i, enemy in ipairs(enemy_stats) do
        if (i - 1) % 8 == 0 then
            table.insert(self.pages, {})
            table.insert(self.buttonPages, {})
        end

        local page = math.floor((i - 1) / 8) + 1

        enemy.image = self.enemiesImages[i]
        enemy.name = language.enemiesNames[i]
        enemy.desc = language.enemiesDesc[i]

        table.insert(self.pages[page], enemy)

        table.insert(self.buttonPages[page], Button({
            x = 130,
            y = 170 + 60 * ((i - 1) % 8),
            width = 480,
            height = 50,
            OnClick = function() self.enemyDisplayed = enemy end
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

function Enemies:update(dt)
    self.next_page_button:update(dt)
    self.previous_page_button:update(dt)
    for _, button in ipairs(self.buttonPages[self.page]) do
        button:update(dt)
    end
end

function Enemies:render()
    love.graphics.draw(self.title, self.titleX, 65)

    if self.page < #self.pages then
        self.next_page_button:render()
    end

    if self.page > 1 then
        self.previous_page_button:render()
    end

    for i, enemy in ipairs(self.pages[self.page]) do
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 130, 170 + 60 * (i - 1), 480, 50)
        love.graphics.setColor(0, 0, 0)

        if not enemy.killedOnce then
            love.graphics.print('????????', 180, 180 + 60 * (i - 1))
            love.graphics.draw(self.enemiesImages[i + 8 * (self.page - 1)], 140, 180 + 60 * (i - 1), 0, 1 / 2)
        else
            love.graphics.print(enemy.name, 180, 180 + 60 * (i - 1))
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.enemiesImages[i + 8 * (self.page - 1)], 140, 180 + 60 * (i - 1), 0, 1 / 2 )
        end
    end

    if self.enemyDisplayed ~= 'none' then
        if self.enemyDisplayed.killedOnce then
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(self.enemyDisplayed.name, VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.printf(self.enemyDisplayed.desc, VIRTUAL_WIDTH / 2 + 50, 455, 452)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.enemyDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
        else
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf('????????', VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.draw(self.enemyDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
            love.graphics.print('?????????????', VIRTUAL_WIDTH / 2 + 110, 505, 0, 2)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function Enemies:checkForKills()
    local dataTable = {}

    progressFile:open('r')
    local playerData = progressFile:read()
    progressFile:close()
    
    for k, v in string.gmatch(playerData, '(%a+)=(%d+)') do
        dataTable[k] = v
    end

    for _, enemy in ipairs(enemy_stats) do
        if not enemy.killedOnce then
            if 1 <= tonumber(dataTable[enemy.condition]) then
                enemy.killedOnce = true
            end
        end
    end
end