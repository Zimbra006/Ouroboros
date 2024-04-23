--[[
    Object class to create every tower's essence
]]

Tower = Class{}

require('Play_thingies.Tower_thingies.Shoot')

function Tower:init(params, enemies, bullets)
    -- identifies the tower
    self.id = params.id

    self.name = params.name
    self.originalName = self.name

    -- deals with tower upgrades
    self.upgraded = false 
    self.upgradeCost = math.floor(tower_stats[self.id].cost * (0.6))
    self.upgradeTier = 0

    -- creates a new parameter if the tower is a cannon
    if self.id == CANNON then
        self.explosion_range = params.explosion_range
    end

    -- every enemy to which the tower can shoot
    self.enemies = enemies

    -- it's image
    self.image = params.image

    -- its position
    self.x = (params.x - 1) * TILE_SIZE + (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2
    self.y = (params.y - 1) * TILE_SIZE + (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2

    -- it's base range
    self.range = params.range
    -- tower's range in pixels, to ease some math
    self.pixelRange = self.range * TILE_SIZE + 32
    -- boolean to whether or not show the tower's range
    self.showRange = false

    -- shoot delay (multiplied by the current multiplier) and a timer to deal with it
    self.delay = params.delay * shootDelayMultiplier
    self.timeUntilShoot = self.delay

    -- bullet's base velocity
    self.shootVel = params.shootVel

    -- the table which this tower will manipulate
    self.bullets = bullets

    -- timer to search an enemy
    self.timerEnemyFinder = 0

    -- it's damage, multiplied by damage buffs
    self.damage = params.damage * damageMultiplier

    -- record the current enemy inside a variable
    self.enemy = 'none'

    -- the current effect which is modding this tower, and its timer to be worn out
    self.effect = 'none'
    self.timerMods = 0
end

function Tower:update(dt)
    -- updates the cost for upgrades, and the tower's range in pixels
    if self.upgraded then
        self.pixelRange = self.range * TILE_SIZE + 32
        self.upgradeCost = math.floor(self.upgradeCost * (1.6))
        self.upgradeTier = self.upgradeTier + 1
        self.name = self.originalName .. '+' .. tostring(self.upgradeTier)
        self.upgraded = false
    end

    -- shoots and updates the bullets
    self:shoot(dt)
    for _, bullet in ipairs(self.bullets) do
        bullet:update(dt)
    end
    -- checks the bullets and delete them under certain conditions
    self:getRidOfBullets()

    if self.effect ~= 'none' then
        self:mods(self.effect, dt)
    end
end

-- function for periodical shooting
function Tower:shoot(dt)
    self.timerEnemyFinder = self.timerEnemyFinder + dt
    local searchForEnemy = 0.5
    
    -- search for an enemy if any of those for things happened: it doesn't has one, it's enemy is far, or dead, or found the base
    if (self.enemy == 'none' or self:checkForOutOfRange(self.enemy) or self.enemy.health <= 0 or self.enemy.foundBase) and self.timerEnemyFinder > searchForEnemy then
        self.timeUntilShoot = self.delay
        self.timerEnemyFinder = 0
        self.enemy = self:movements()
    end

    -- if there's an enemy, shoot it until it's dead
    if self.enemy ~= 'none' then
        self.timeUntilShoot = self.timeUntilShoot - dt
        if self.timeUntilShoot <= 0 then
            self.timeUntilShoot = self.delay
            table.insert(self.bullets, Shoot(self, self.enemy))
        end
    end
end

-- function that makes the tower detect enemy movement, and returns the closest one
function Tower:movements()
    -- find the closest enemy
    local shortestDist = math.huge
    local closestEnemy = 'none'

    for _, enemy in ipairs(self.enemies) do
        local distToEnemy = distanceBetween(self, enemy)
        if distToEnemy < shortestDist then
            shortestDist = distToEnemy
            closestEnemy = enemy
        end
    end

    -- if it's inside the range, return the closest enemy
    if shortestDist < self.pixelRange then
        return closestEnemy
    else
        return 'none'
    end
end

-- function to check if the enemy is too far away
function Tower:checkForOutOfRange(enemy)
    if enemy ~= 'none' then
        return distanceBetween(self, enemy) > self.pixelRange
    else
        return false
    end
end

-- function to delete bullets if: it's too far, it's too old, the enemy is dead, or if it hit the enemy
function Tower:getRidOfBullets()
    for i, bullet in ipairs(self.bullets) do
        if bullet.enemy.health <= 0 or bullet.hitEnemy or bullet.timer > 1 or distanceBetween(self, bullet) > self.pixelRange + 10 then
            table.remove(self.bullets, i)
        end
    end
end

function Tower:mods(modifier, dt)
    self.timerMods = self.timerMods + dt

    if modifier == 'stronger' then
        self.damage = self.damage * 2
    elseif modifier == 'faster' then
        self.shootVel = self.shootVel * 1.5
    end

    if self.timerMods > 15 then
        if modifier == 'stronger' then
            self.damage = self.damage / 2
        elseif modifier == 'faster' then
            self.shootVel = self.shootVel / 1.5
        end
        
        self.effect = 'none'
        self.timerMods = 0
    end
end

function Tower:render()
    -- draws the tower
    love.graphics.draw(self.image, self.x, self.y)

    -- shows its range, if asked
    if self.showRange then
        for i = 1, 100 do
            love.graphics.setColor(26 / 255, 117 / 255 , 101 / 255, 0.5 - i / 100)
            love.graphics.circle('line', self.x + 32, self.y + 32, self.pixelRange - i)
            love.graphics.setColor(1, 1, 1)
        end
    end
end