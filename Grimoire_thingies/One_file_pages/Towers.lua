--[[
    file to catalogue the towers
]]

Towers = Class{}

function Towers:init()
    self:checkForUnlockeds()

    self.title = language.towersTitle
    self.titleX = 130
    self.statsX = 430

    self.pages = {}
    self.buttonPages = {}
    self.page = 1

    self.towersImages = {
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

    self.towerDisplayed = 'none'

    for i, tower in ipairs(tower_stats) do
        if (i - 1) % 8 == 0 then
            table.insert(self.pages, {})
            table.insert(self.buttonPages, {})
        end

        local page = math.floor((i - 1) / 8) + 1

        tower.image = self.towersImages[i]

        table.insert(self.pages[page], tower)

        table.insert(self.buttonPages[page], Button({
            x = 130,
            y = 170 + 60 * ((i - 1) % 8),
            width = 480,
            height = 50,
            OnClick = function() self.towerDisplayed = tower self.towerDisplayed.image = self.towersImages[i] end
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

function Towers:update(dt)
    self.next_page_button:update(dt)
    self.previous_page_button:update(dt)
    for _, button in ipairs(self.buttonPages[self.page]) do
        button:update(dt)
    end
end

function Towers:render()
    love.graphics.draw(self.title, self.titleX, 65)

    if self.page < #self.pages then
        self.next_page_button:render()
    end

    if self.page > 1 then
        self.previous_page_button:render()
    end

    for i, tower in ipairs(self.pages[self.page]) do
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 130, 170 + 60 * (i - 1), 480, 50)
        love.graphics.setColor(0, 0, 0)

        if not tower.unlocked then
            love.graphics.print('????????', 180, 180 + 60 * (i - 1))
            love.graphics.draw(self.towersImages[i + 8 * (self.page - 1)], 140, 180 + 60 * (i - 1), 0, 1 / 2)
        else
            love.graphics.print(tower.name, 180, 180 + 60 * (i - 1))
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.towersImages[i + 8 * (self.page - 1)], 140, 180 + 60 * (i - 1), 0, 1 / 2 )
        end
    end

    if self.towerDisplayed ~= 'none' then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(language.towerBaseStats, VIRTUAL_WIDTH / 2 + 50, 460)
        love.graphics.print(language.towerStatRange .. ':', VIRTUAL_WIDTH / 2 + 50, 510)
        love.graphics.print(language.towerStatDamage .. ':', VIRTUAL_WIDTH / 2 + 50, 560)
        love.graphics.print(language.towerStatShootVel .. ':', VIRTUAL_WIDTH / 2 + 230, 510)
        love.graphics.print(language.towerStatShootDelay .. ':', VIRTUAL_WIDTH / 2 + 230, 560)
        
        if self.towerDisplayed.unlocked then
            love.graphics.setColor(0, 0, 0)
            if string.len(self.towerDisplayed.name) > 10 then
                love.graphics.printf(self.towerDisplayed.name, VIRTUAL_WIDTH / 2 + 176, 55, 140, "center", 0, 3 / 2)
            else
                love.graphics.printf(self.towerDisplayed.name, VIRTUAL_WIDTH / 2 + 116, 65, 170, "center", 0, 2)
            end
            love.graphics.print(self.towerDisplayed.range, VIRTUAL_WIDTH / 2 + 160, 510)
            love.graphics.print(self.towerDisplayed.damage, VIRTUAL_WIDTH / 2 + 160, 560)
            love.graphics.print(self.towerDisplayed.shootVel, VIRTUAL_WIDTH / 2 + self.statsX, 510)
            love.graphics.print(self.towerDisplayed.delay, VIRTUAL_WIDTH / 2 + self.statsX, 560)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.towerDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
        else
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf('????????', VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.draw(self.towerDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
            love.graphics.print('???', VIRTUAL_WIDTH / 2 + 160, 510)
            love.graphics.print('???', VIRTUAL_WIDTH / 2 + 160, 560)
            love.graphics.print('???', VIRTUAL_WIDTH / 2 + self.statsX, 510)
            love.graphics.print('???', VIRTUAL_WIDTH / 2 + self.statsX, 560)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function Towers:checkForUnlockeds()
    for i, tower in ipairs(tower_stats) do
        if not tower.unlocked then
            if achievements.towers[i - 1].made then
                tower.unlocked = true
            end
        end
    end
end