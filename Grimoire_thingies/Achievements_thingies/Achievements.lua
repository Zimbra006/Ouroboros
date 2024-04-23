--[[
    file to manipulate the achievements table, as well as displaying it
]]

require('Grimoire_thingies.Achievements_thingies/achievements_table')

Achievements = Class{}

function Achievements:init()
    self:tableUpdate()

    self.title = language.achievementsTitle
    -- design purposes
    self.titleX = 130

    -- respectively: stores the achievements in order, stores the buttons to show these
    -- achievemnts in detail, stores the current page being displayed
    self.pages = {}
    self.buttonPages = {}
    self.page = 1

    self.achievementsImages = {
        love.graphics.newImage('Graphics/Towers/sniper.png'),
        love.graphics.newImage('Graphics/Towers/cannon.png'),
        love.graphics.newImage('Graphics/Towers/sauron.png'),
        love.graphics.newImage('Graphics/Details/pergaminho.png')
    }

    -- the current achievemnt being displayed
    self.achievementDisplayed = 'none'

    local i = 0

    for _, category in pairs(achievements) do
        for _, achievement in ipairs(category) do
            if i % 8 == 0 then
                table.insert(self.pages, {})
                table.insert(self.buttonPages, {})
            end

            local page = math.floor(i / 8) + 1

            achievement.image = self.achievementsImages[i + 1]

            table.insert(self.pages[page], achievement)

            table.insert(self.buttonPages[page], Button({
                x = 130,
                y = 170 + 60 * (i % 8),
                width = 480,
                height = 50,
                OnClick = function() self.achievementDisplayed = achievement end
            }))

            i = i + 1
        end
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

function Achievements:update(dt)
    self.next_page_button:update(dt)
    self.previous_page_button:update(dt)
    for _, button in ipairs(self.buttonPages[self.page]) do
        button:update(dt)
    end
end

function Achievements:render()
    love.graphics.draw(self.title, self.titleX, 65)
    
    if self.page < #self.pages then
        self.next_page_button:render()
    end

    if self.page > 1 then
        self.previous_page_button:render()
    end

    local trophy = love.graphics.newImage('Graphics/Details/trophy.png')

    for i, achievement in ipairs(self.pages[self.page]) do
        love.graphics.setColor(0, 0, 0, 0.2)
        love.graphics.rectangle('fill', 130, 170 + 60 * (i - 1), 480, 50)
        love.graphics.setColor(0, 0, 0)

        if not achievement.made then
            love.graphics.print('????????', 180, 180 + 60 * (i - 1))
            love.graphics.draw(trophy, 140, 180 + 60 * (i - 1), 0, 1 / 2)
        else
            love.graphics.print(achievement.title, 180, 180 + 60 * (i - 1))
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(trophy, 140, 180 + 60 * (i - 1), 0, 1 / 2 )
        end
    end

    if self.achievementDisplayed ~= 'none' then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(language.condition, VIRTUAL_WIDTH / 2 + 78, 490, 0, 1.5)
        love.graphics.print('- ' .. self.achievementDisplayed.desc[1] .. self.achievementDisplayed.quantity .. self.achievementDisplayed.desc[2], VIRTUAL_WIDTH / 2 + 78, 540)
        love.graphics.print(language.unlock, VIRTUAL_WIDTH / 2 + 348, 490, 0, 1.5)
        
        if self.achievementDisplayed.made then
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(self.achievementDisplayed.title, VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.print('- ' .. self.achievementDisplayed.unlock, VIRTUAL_WIDTH / 2 + 368, 540)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.achievementDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
        else
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf('????????', VIRTUAL_WIDTH / 2 + 166, 65, 120, "center", 0, 2)
            love.graphics.draw(self.achievementDisplayed.image, VIRTUAL_WIDTH / 2 + 190, 180, 0, 3)
            love.graphics.print('?????????????', VIRTUAL_WIDTH / 2 + 348, 540)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

function Achievements:tableUpdate()
    local dataTable = {}

    progressFile:open('r')
    local playerData = progressFile:read()
    progressFile:close()
    
    for k, v in string.gmatch(playerData, '(%a+)=(%d+)') do
        dataTable[k] = v
    end

    for _, category in pairs(achievements) do
        for _, achievement in ipairs(category) do
            if not achievement.made then
                if achievement.quantity <= tonumber(dataTable[achievement.condition]) then
                    achievement.made = true
                end
            end
        end
    end
end