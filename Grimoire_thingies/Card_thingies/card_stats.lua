--[[
    File to store the cards properties
]]

-- a handful of global modifiers to spice up gameplay
enemySpeed = 1
chanceToBurn = 0
moneyMultiplier = 1
towerPriceMultiplier = 1
upgradePriceMultiplier = 1
startingTowers = 0
damageMultiplier = 1
shootDelayMultiplier = 1

card_stats = {
    {
        -- slows down enemies
        effect = function() enemySpeed = 0.5 end,
        reset = function() enemySpeed = 1 end,
        message = language.cards[1]
    },
    {
        -- adds a chance to burn enemies
        effect = function() chanceToBurn = 5 end,
        reset = function() chanceToBurn = 0 end,
        message = language.cards[2]
    },
    {
        -- adds 30% more money
        effect = function() moneyMultiplier = 1.3 end,
        reset = function() moneyMultiplier = 1 end,
        message = language.cards[3]
    },
    {
        -- discounts on every tower; the manager went crazy!
        effect = function() towerPriceMultiplier = 0.8 end,
        reset = function() towerPriceMultiplier = 1 end,
        message = language.cards[4]
    },
    {
        -- discounts on every upgrade
        effect = function() upgradePriceMultiplier = 0.8 end,
        reset = function() upgradePriceMultiplier = 1 end,
        message = language.cards[5]
    },
    {
        -- adds two randomly placed initial towers
        effect = function() startingTowers = 2 end,
        reset = function() startingTowers = 0 end,
        message = language.cards[6]
    },
    {
        -- adds 30% of damage to every tower
        effect = function() damageMultiplier = 1.3 end,
        reset = function() damageMultiplier = 1 end,
        message = language.cards[7]
    },
    {
        -- narrows the time between each shot
        effect = function() shootDelayMultiplier = 0.7 end,
        reset = function() shootDelayMultiplier = 1 end,
        message = language.cards[8]
    }
}