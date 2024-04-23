--[[
    file to remember all the achievements in the game
]]

achievements = {
    towers = 
    {
        {
            made = false,
            condition = 'gamesPlayed',
            quantity = 1,
            unlock = language.achievementsUnlocks[1],
            title = language.achievementsNames[1],
            desc = language.achievementsDescs[1]
        },
        {
            made = false,
            condition = 'totalEnemiesKilled',
            quantity = 100,
            unlock = language.achievementsUnlocks[2],
            title = language.achievementsNames[2],
            desc = language.achievementsDescs[2]
        },
        { 
            made = false,
            condition = 'impsKilled',
            quantity = 180,
            unlock = language.achievementsUnlocks[3],
            title = language.achievementsNames[3],
            desc = language.achievementsDescs[3]
        }
    },
    recipes = 
    {
        {
            id = 'slowness',
            made = false,
            condition = 'elfsKilled',
            quantity = 40,
            unlock = language.achievementsUnlocks[4],
            title = language.achievementsNames[4],
            desc = language.achievementsDescs[4]
        }
    }
}

