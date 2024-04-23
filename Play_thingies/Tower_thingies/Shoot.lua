--[[
    Object class for an individual bullet
]]

Shoot = Class{}

local shotsSkins = {
    love.graphics.newImage('Graphics/Towers/Tiros/basicShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/sniperShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/reCaptainShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/glassTowerShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/clampShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/magicLightShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/cagedFlowerShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/plasmaBeamShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/teslaShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/sauronShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/cannonShot.png'),
    love.graphics.newImage('Graphics/Towers/Tiros/tankShot.png')
}

function Shoot:init(tower, enemy)
    -- links the bullet with its tower and enemy
    self.tower = tower
    self.enemy = enemy

    -- damage giving thingy
    self.damage = tower.damage

    self.spritesheet = shotsSkins[self.tower.id]

    -- timer to check its lifespan
    self.timer = 0

    self.x = tower.x + 32
    self.y = tower.y + 32
        
    local toEnemy = distanceBetween(self, self.enemy)

    -- so that the normal 100 velocity stays constant, does some vectorial math
    self.dx = (100 / toEnemy) * (math.abs(self.enemy.x - self.x)) * tower.shootVel
    self.dy = (100 / toEnemy) * (math.abs(self.enemy.y - self.y)) * tower.shootVel

    -- cehcks for hitting
    self.hitEnemy = false
end

function Shoot:update(dt)
    self.timer = self.timer + dt
    self:checkForHit()
    self:followEnemy(dt)
end

-- code to follow the enemy, base on its position and the self position
function Shoot:followEnemy(dt)
    enemyPos = {
        x = self.enemy.x + 32,
        y = self.enemy.y + 32
    }

    if self.x < enemyPos.x then 						
        self.x = self.x + (self.dx * 2.5 * dt)			
    end
     
    if self.x > enemyPos.x then 						
        self.x = self.x - (self.dx * 2.5 * dt) 			
    end
     
    if self.y < enemyPos.y then 						
        self.y = self.y + (self.dy * 2.5 * dt)			
    end
     
    if self.y > enemyPos.y then 						
        self.y = self.y - (self.dy * 2.5 * dt)			
    end

    self:acceleration(dt)
end

-- accelerates the bullet, just to save time
function Shoot:acceleration(dt)
    self.dx = self.dx + 150 * dt
    self.dy = self.dy + 150 * dt
end

-- check for a collision between itself and the enemy, if so, signal it and damage the enemy
function Shoot:checkForHit()
    if self.x > self.enemy.x and self.x + 4 < self.enemy.x + TILE_SIZE and self.y > self.enemy.y and self.y + 4 < self.enemy.y + TILE_SIZE then
        self.enemy.health = self.enemy.health - self.damage
        -- based on the current chance of burning, lits the enemy
        if self.tower.id ~= SAURON and math.random(1, 100) <= chanceToBurn then
            self.enemy.state = 'burningAAAAAAAA'
        end
        -- updates the global objective of damage giving
        damageDealt = damageDealt + self.damage
        damageByTowers[self.tower.id] = damageByTowers[self.tower.id] + self.damage
        self.hitEnemy = true
    end
end

function Shoot:render()
    love.graphics.draw(self.spritesheet, self.x - 10, self.y - 10)
end