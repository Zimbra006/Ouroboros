--[[
    A class to create all enemies, based on their stats
]]

Enemy = Class{}

function Enemy:init(map, params)
    -- links enemy with map
    self.map = map

    -- stores which enemy it is
    self.type = params.type

    -- its visual archive
    self.skin = params.skin

    -- initial position for all enemies
    self.x = (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2
    self.y = (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2

    -- random intial direction
    self.direction = 'down'

    -- initial velocity, multplied by the current speed multiplier
    self.speed = params.speed  * enemySpeed
    self.originalSpeed = self.speed
    self.dx = 0
    self.dy = self.speed

    -- its health
    self.health = params.health
    self.originalHealth = self.health
    -- a value to make a little math so it shows the current health with proportion (initialHelath is to 64 as actual health is to x)
    self.initialHealth = params.health

    -- its damage
    self.damage = params.damage

    -- boolean to signal when it has found the base
    self.foundBase = false

    -- stores the current modifier for the enemy, and a timer for this to pass
    self.state = 'fine'
    self.stateTimer = 0
end

function Enemy:update(dt)
    -- updates the never stoping enemy
    self:followPath()
    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt
    -- if he isn't fine, he is suffering from a mod
    if self.state ~= 'fine' then
        self:sufferFromModifier(self.state, dt)
    end
end

-- gives a little intelligence for the enemy, so it walks along the path
function Enemy:followPath()
    -- given the direction, store values to guarante that the block in front of the enemy is the one being analyzed
    checkX, checkY = 0, 0
    if self.direction == 'down' then
        checkY = 1
    elseif self.direction == 'left' then
        checkX = -1
    elseif self.direction == 'up' then
        checkY = -1
    elseif self.direction == 'right' then
        checkX = 1
    end
    -- stores the current block where the enemy is standing
    local currentBlock = self.map:blockAt(self.x + 5, self.y + 5)
    -- stores the coordinates of the block in front of the enemy, with the map's x and y being the origin
    local nextBlockCo = {
        x = self.x - (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2 + checkX + TILE_SIZE * (checkX + 1) / 2,
        y = self.y - (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2 + checkY + TILE_SIZE * (checkY + 1) / 2
    }


    -- if it is looking at the border, don't index smtg that doesn't exists
    if nextBlockCo.x + checkX > self.map.mapWidth * TILE_SIZE or nextBlockCo.x + checkX < 0 or nextBlockCo.y + checkY > self.map.mapHeight * TILE_SIZE or nextBlockCo.y + checkY < 0 then
        if currentBlock.id ~= CAMPFIRE then
            self:stop(self.direction)
            -- check for surronding blocks for a path and go along it
            self:changeDirection(self:lookForPath(currentBlock))
        else
            -- if base is found, signal
            self.foundBase = true
            global_health = global_health - self.damage
        end
    -- if it isn't looking at the border, just go along with it
    elseif self.map.map[math.ceil(nextBlockCo.y / TILE_SIZE)][math.ceil(nextBlockCo.x / TILE_SIZE)] ~= ROAD and self.map.map[math.ceil(nextBlockCo.y / TILE_SIZE)][math.ceil(nextBlockCo.x / TILE_SIZE)] ~= CAMPFIRE then
        self:stop(self.direction)
        -- check for surronding blocks for a path and go along it
        self:changeDirection(self:lookForPath(currentBlock))
    end
end

-- stops the enemy, exciting.
function Enemy:stop(direction)
    if direction == 'down' or direction == 'up' then
        self.dy = 0
    else
        self.dx = 0
    end
end

-- looks for a path when it has found an obstacle, not checking the abyss beyond the border, and returns its direction
function Enemy:lookForPath(currentBlock)
    if currentBlock.x + 1 <= self.map.mapWidth and self.direction ~= 'left' then
        local rightBlock = self.map.map[currentBlock.y][currentBlock.x + 1]
        if rightBlock == ROAD or rightBlock == CAMPFIRE then
            return 'right'
        end
    end
    if currentBlock.x - 1 >= 1 and self.direction ~= 'right' then
        local leftBlock = self.map.map[currentBlock.y][currentBlock.x - 1]
        if leftBlock == ROAD or leftBlock == CAMPFIRE then
            return 'left'
        end
    end
    if currentBlock.y + 1 <= self.map.mapHeight and self.direction ~= 'up' then
        local downBlock = self.map.map[currentBlock.y + 1][currentBlock.x]
        if downBlock == ROAD or downBlock == CAMPFIRE then
            return 'down'
        end
    end
    if currentBlock.y - 1 >= 1 and self.direction ~= 'down' then
        local upBlock = self.map.map[currentBlock.y - 1][currentBlock.x]
        if upBlock == ROAD or upBlock == CAMPFIRE then
            return 'up'
        end
    end
end

-- change enemy's march based on a new direction
function Enemy:changeDirection(new_direction)
    if new_direction == 'left' then
        self.direction = 'left'
        self.dx = -self.speed
    elseif new_direction == 'up' then
        self.direction = 'up'
        self.dy = -self.speed
    elseif new_direction == 'right' then
        self.direction = 'right'
        self.dx = self.speed
    elseif new_direction == 'down' then
        self.direction = 'down'
        self.dy = self.speed
    end
end

-- makes the enemy suffer
function Enemy:sufferFromModifier(modifier, dt)
    if modifier == 'burningAAAAAAAA' then
        self.stateTimer = self.stateTimer + dt
        self.health = self.health - (self.originalHealth / 30)
    elseif modifier == 'slow' then
        self.stateTimer = self.stateTimer + dt
        self.speed = self.originalSpeed / 2
        if self.direction == 'up' then
            self.dy = -self.speed
        elseif self.direction == 'down' then
            self.dy = self.speed
        elseif self.direction == 'left' then
            self.dx = -self.speed
        elseif self.direction == 'right' then
            self.dx = self.speed
        end
    elseif modifier == 'frozen' then
        self.stateTimer = self.stateTimer + dt
        self.dx = 0
        self.dy = 0
    end
    if modifier ~= 'fine' and self.stateTimer >= 2 then
        self.stateTimer = 0
        self.state = 'fine'
        self.speed = self.originalSpeed
        if self.direction == 'up' then
            self.dy = -self.speed
        elseif self.direction == 'down' then
            self.dy = self.speed
        elseif self.direction == 'left' then
            self.dx = -self.speed
        elseif self.direction == 'right' then
            self.dx = self.speed
        end
    end
end

-- draws it
function Enemy:render()
    if self.state == 'burningAAAAAAAA' then
        love.graphics.setColor(1, 61 / 255, 61 / 255)
    elseif self.state == 'frozen' then
        love.graphics.setColor(72 / 255, 217 / 255, 200 / 255)
    end
    love.graphics.draw(self.skin, self.x, self.y)
    if self.health > 0 then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle('fill', self.x, self.y + 65, self.health * TILE_SIZE / self.initialHealth, 5)
    end
    love.graphics.setColor(1, 1, 1)
end