--[[
    stats to make the enemies

    TODO:
    -> types be made into the consts for each enemy (type = BOO, type = DINOSSAURIN, etcs)
    -> create names for each enemy, in both languages
]]

-- global variables for each enemy
ELF = 1
IMP = 2
GENIE = 3
LAND_MAN = 4
DINO = 5
BOITATA = 6
CENTAUR = 7
MEDUSA = 8
OLD_SAGE = 9
WITCH = 10
ORC = 11
HEADLESS_MULE = 12
BLACK_GOAT = 13
OUROBOROS = 14

enemy_stats = {
    {
        type = ELF,
        speed = 70,
        health = 15,
        damage = 1,
        condition = 'elfsKilled',
        killedOnce = false
    },
    {
        type = IMP,
        speed = 120,
        health = 9,
        damage = 1,
        condition = 'impsKilled',
        killedOnce = false
    },
    {
        type = GENIE,
        speed = 130,
        health = 6,
        damage = 1,
        condition = 'geniesKilled',
        killedOnce = false
    },
    {
        type = LAND_MAN,
        speed = 150,
        health = 5,
        damage = 1,
        condition = 'landMenKilled',
        killedOnce = false
    },
    {
        type = DINO,
        speed = 50,
        health = 30,
        damage = 1,
        condition = 'dinosKilled',
        killedOnce = false
    },
    {
        type = BOITATA,
        speed = 170,
        health = 4,
        damage = 1,
        condition = 'boitatasKilled',
        killedOnce = false
    },
    {
        type = CENTAUR,
        speed = 120,
        health = 17,
        damage = 1,
        condition = 'centaursKilled',
        killedOnce = false
    },
    {
        type = MEDUSA,
        speed = 90,
        health = 15,
        damage = 1,
        condition = 'medusasKilled',
        killedOnce = false
    },
    {
        type = OLD_SAGE,
        speed = 70,
        health = 20,
        damage = 1,
        condition = 'oldSagesKilled',
        killedOnce = false
    },
    {
        type = WITCH,
        speed = 90,
        health = 20,
        damage = 1,
        condition = 'witchesKilled',
        killedOnce = false
    },
    {
        type = ORC,
        speed = 40,
        health = 40,
        damage = 1,
        condition = 'orcsKilled',
        killedOnce = false
    },
    {
        type = HEADLESS_MULE,
        speed = 120,
        health = 23,
        damage = 2,
        condition = 'headlessMulesKilled',
        killedOnce = false
    },
    {
        type = BLACK_GOAT,
        speed = 90,
        health = 25,
        damage = 2,
        condition = 'blackGoatsKilled',
        killedOnce = false
    },
    {
        type = OUROBOROS,
        speed = 50,
        health = 100,
        damage = 25,
        condition = 'ouroborosKilled',
        killedOnce = false
    }
}