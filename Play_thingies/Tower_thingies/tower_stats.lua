--[[
    file to store tower stats
]]

--[[
    weakest to strongest:
    basic
    sniper
    reCaptain
    glass tower
    clamp
    magic light
    caged flower
    plasma beam
    tesla
    sauron
    cannon
    tank
]]

-- global variables for different towers
BASIC = 1
SNIPER = 2
RECAPTAIN = 3
GLASS_TOWER = 4
CLAMP = 5
MAGIC_LIGHT = 6
CAGED_FLOWER = 7
PLASMA_BEAM = 8
TESLA = 9
SAURON = 10
CANNON = 11
TANK = 12

tower_stats = {
    {
        id = BASIC,
        name = language.towers[BASIC].name,
        desc = language.towers[BASIC].desc,
        range = 1.7,
        delay = 0.7,
        shootVel = 1.5,
        damage = 3.5,
        cost = 37,
        unlocked = true
    },
    {
        id = SNIPER,
        name = language.towers[SNIPER].name,
        desc = language.towers[SNIPER].desc,
        range = 7,
        delay = 1.3,
        shootVel = 8,
        damage = 7,
        cost = 65,
        unlocked = true
    },
    {
        id = RECAPTAIN,
        name = language.towers[RECAPTAIN].name,
        desc = language.towers[RECAPTAIN].desc,
        range = 3,
        delay = 0.1,
        shootVel = 3,
        damage = 0.1,
        cost = 50,
        unlocked = true
    },
    {
        id = GLASS_TOWER,
        name = language.towers[GLASS_TOWER].name,
        desc = language.towers[GLASS_TOWER].desc,
        range = 2,
        delay = 1.9,
        shootVel = 1.1,
        damage = 5,
        cost = 43,
        unlocked = true
    },
    {
        id = CLAMP,
        name = language.towers[CLAMP].name,
        desc = language.towers[CLAMP].desc,
        range = 1.2,
        delay = 0.9,
        shootVel = 1,
        damage = 1.7,
        cost = 70,
        unlocked = true
    },
    {
        id = MAGIC_LIGHT,
        name = language.towers[MAGIC_LIGHT].name,
        desc = language.towers[MAGIC_LIGHT].desc,
        range = 3,
        delay = 1.5,
        shootVel = 13,
        damage = 5,
        cost = 30,
        unlocked = true
    },
    {
        id = CAGED_FLOWER,
        name = language.towers[CAGED_FLOWER].name,
        desc = language.towers[CAGED_FLOWER].desc,
        range = 3.5,
        delay = 10,
        shootVel = 1.3,
        damage = 2,
        cost = 60,
        unlocked = true
    },
    {
        id = PLASMA_BEAM,
        name = language.towers[PLASMA_BEAM].name,
        desc = language.towers[PLASMA_BEAM].desc,
        range = 6,
        delay = 2.9,
        shootVel = 8,
        damage = 13,
        cost = 77,
        unlocked = true
    },
    {
        id = TESLA,
        name = language.towers[TESLA].name,
        desc = language.towers[TESLA].desc,
        range = 4,
        delay = 0.3,
        shootVel = 5,
        damage = 10,
        cost = 65,
        unlocked = true
    },
    {
        id = SAURON,
        name = language.towers[SAURON].name,
        desc = language.towers[SAURON].desc,
        range = 2,
        delay = 1,
        shootVel = 10,
        damage = 2,
        cost = 60,
        unlocked = true
    },
    {
        id = CANNON,
        name = language.towers[CANNON].name,
        desc = language.towers[CANNON].desc,
        range = 1.5,
        delay = 1.7,
        shootVel = 1.3,
        damage = 8,
        explosion_range = 1.5,
        cost = 52,
        unlocked = true
    },
    {
        id = TANK,
        name = language.towers[TANK].name,
        desc = language.towers[TANK].desc,
        range = 1.2,
        delay = 3,
        shootVel = 1,
        damage = 20, 
        cost = 80,
        unlocked = true
    }
}