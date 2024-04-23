--[[
    Creates a logic for enemy waves
]]

Waves = Class{}

require('Play_thingies.Enemy_thingies.enemy_stats')
require('Play_thingies.Enemy_thingies.Enemy')

function Waves:init(params)
    -- links wave and map
    self.map = params.map

    -- stores the enemy type and how much to spawn
    self.enemiesToGo = params.enemyAmount
    self.enemyType = params.enemyType

    -- life multiplier based on wave
    self.multiplier = 1 + (wave / 10) * (math.floor(wave / 15) + 1)

    -- based on the enemy, create its stats
    self.enemyParams = {}

    self.enemy_skins = {
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

    self.enemyParams = enemy_stats[self.enemyType]

    self.enemyParams.health = self.enemyParams.health * self.multiplier
    self.enemyParams.skin = self.enemy_skins[self.enemyType]

    -- a little table to store this wave's enemies
    self.enemies = params.enemyTable

    -- time between each spawn
    self.spawnTime = params.spawnTime
    -- timer to periodic spawning (starts greater than spawnTime so it instantly spawns the first one)
    self.spawnTimer = self.spawnTime + 1
end

function Waves:update(dt)
    -- increases spawn timer
    self.spawnTimer = self.spawnTimer + dt
    -- SPAWNING YEY
    self:spawnEnemies()
end

function Waves:spawnEnemies()
    -- if it hasn't yet spawned every enemy, continues
    if self.enemiesToGo > 0 then
        -- but only when the time is right
        if self.spawnTimer > self.spawnTime then
            self.spawnTimer = 0
            table.insert(self.enemies, Enemy(self.map, self.enemyParams))
            self.enemiesToGo = self.enemiesToGo - 1
        end
    end
end