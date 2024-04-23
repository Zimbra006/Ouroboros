--[[
    File for statistics screen
]]

Stats = Class{}

function Stats:init()
    self.background = love.graphics.newImage('Graphics/Details/tela_estatisticas.png')
    self.statsTable = {}
    progressFile:open('r')
    local playerData = progressFile:read()
    progressFile:close()

    for k, v in string.gmatch(playerData, '(%a+)=(%d+)') do
        self.statsTable[k] = v
    end

    self.returnButton = Button({
        x = VIRTUAL_WIDTH - 125,
        y = 20,
        image = love.graphics.newImage('Graphics/Buttons/back.png'),
        OnClick = function() game_state = 'menu' end
    })
end

function Stats:update(dt)
    self.returnButton:update(dt)
end

function Stats:render()
    love.graphics.draw(self.background)
    self.returnButton:render()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.statsTable['gamesPlayed'], 750, 35)
    love.graphics.print(language.stats.highscore .. self.statsTable['highscore'], 100, 35)
    love.graphics.print(language.stats.killing, 100, 70)
    love.graphics.print(language.stats.totalKilled .. self.statsTable['totalEnemiesKilled'], 120, 105)
    love.graphics.print(language.stats.boosKilled  .. self.statsTable['elfsKilled'], 120, 140)
    love.graphics.print(language.stats.meaniesKilled .. self.statsTable['impsKilled'], 120, 175)
    love.graphics.print(language.stats.vampirinsKilled .. self.statsTable['geniesKilled'], 120, 210)
    love.graphics.print(language.stats.skellysKilled .. self.statsTable['landMenKilled'], 120, 245)
    love.graphics.print(language.stats.dinosKilled .. self.statsTable['dinosKilled'], 120, 280)
    love.graphics.print(language.stats.snakiesKilled .. self.statsTable['boitatasKilled'], 120, 315)
    love.graphics.print(language.stats.expenses, 100, 350)
    love.graphics.print(language.stats.towersBought .. self.statsTable['totalTowersBought'], 120, 385)
    love.graphics.print(language.stats.basicsBought .. self.statsTable['basicTowersBought'], 120, 420)
    love.graphics.print(language.stats.snipersBought .. self.statsTable['sniperTowersBought'], 120, 455)
    love.graphics.print(language.stats.cannonsBought .. self.statsTable['cannonTowersBought'], 120, 490)
    love.graphics.print(language.stats.sauronsBought .. self.statsTable['sauronTowersBought'], 120, 525)
    love.graphics.print(language.stats.damage, 100, 560)
    love.graphics.print(language.stats.totalDamage .. self.statsTable['totalDamageDealt'], 120, 595)
    love.graphics.print(language.stats.basicDamage .. self.statsTable['damageByBasic'], 120, 630)
    love.graphics.print(language.stats.sniperDamage .. self.statsTable['damageBySniper'], 120, 665)
    love.graphics.print(language.stats.cannonDamage .. self.statsTable['damageByCannon'], 120, 700)
    love.graphics.print(language.stats.sauronDamage .. self.statsTable['damageBySauron'], 120, 735)
    love.graphics.setColor(1, 1, 1)
end