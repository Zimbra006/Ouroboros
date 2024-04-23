--[[
    Useful functions for the game
]]

function geneQuads(atlas, tileWidth, tileHeight)
    tileHeight = tileHeight or tileWidth

    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local quads = {}

    for y = 1, sheetHeight do
        for x = 1, sheetWidth do
            quads[sheetCounter] = love.graphics.newQuad((x - 1) * tileWidth, (y - 1) * tileHeight,
            tileWidth, tileHeight, atlas:getDimensions())

            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

-- returns the distance by geometry
function distanceBetween(A, B)
    return ((B.x - A.x) ^ 2 + (B.y - A.y) ^ 2) ^ 0.5
end

-- updates static data having to do with language when the games has its language changed
-- ex.: in Deck.lua, the title, being defined in the init function, won't change if I don't change it manually here, 'cause init will only be called once
function updateStats()
    for i = 1, #tower_stats do
        tower_stats[i].name = language.towers[i].name
        tower_stats[i].desc = language.towers[i].desc
    end

    for i, row in ipairs(grimoire_screen.deck_page.cardsCollection) do
        for j, card in ipairs(row) do
            card.message = language.cards[(i - 1) * 4 + j]
        end
    end
    
    for i, achievement in ipairs(achievements) do
        achievement.unlock = language.achievementsUnlocks[i]
        achievement.title = language.achievementsNames[i]
        achievement.desc = language.achievementsDescs[i]
    end

    if language.metalanguage == 'English' then
        grimoire_screen.deck_page.titleX = 150
        grimoire_screen.achievement_page.titleX = 130
        grimoire_screen.enemies_page.titleX = 125
        grimoire_screen.towers_page.titleX = 130
        grimoire_screen.towers_page.statsX = 430
        grimoire_screen.recipes_page.titleX = 140
    else
        grimoire_screen.deck_page.titleX = 133
        grimoire_screen.achievement_page.titleX = 135
        grimoire_screen.enemies_page.titleX = 130
        grimoire_screen.towers_page.titleX = 140
        grimoire_screen.towers_page.statsX = 480
        grimoire_screen.recipes_page.titleX = 135
    end
end

-- updates the file reporting on the player progress
function updateProgress()
    local dataTable = {}

    progressFile:open('r')
    local playerData = progressFile:read()
    progressFile:close()

    for k, v in string.gmatch(playerData, '(%a+)=(%d+)') do
        dataTable[k] = v
    end

    local highscore = tonumber(dataTable['highscore'])
    if wave > highscore then
        highscore = wave
        dataTable['highscore'] = tostring(highscore)
    end

    dataTable['gamesPlayed'] = tostring(tonumber(dataTable['gamesPlayed']) + 1)
    dataTable['totalEnemiesKilled'] = tostring(killed_enemies  + tonumber(dataTable['totalEnemiesKilled']))
    dataTable['elfsKilled'] = tostring(killed_elfs + tonumber(dataTable['elfsKilled']))
    dataTable['impsKilled'] = tostring(killed_imps + tonumber(dataTable['impsKilled']))
    dataTable['geniesKilled'] = tostring(killed_genies + tonumber(dataTable['geniesKilled']))
    dataTable['landMenKilled'] = tostring(killed_land_men + tonumber(dataTable['landMenKilled']))
    dataTable['dinosKilled'] = tostring(killed_dinos + tonumber(dataTable['dinosKilled']))
    dataTable['boitatasKilled'] = tostring(killed_boitatas + tonumber(dataTable['boitatasKilled']))
    dataTable['centaursKilled'] = tostring(killed_centaurs + tonumber(dataTable['centaursKilled']))
    dataTable['medusasKilled'] = tostring(killed_medusas + tonumber(dataTable['medusasKilled']))
    dataTable['oldSagesKilled'] = tostring(killed_old_sages + tonumber(dataTable['oldSagesKilled']))
    dataTable['witchesKilled'] = tostring(killed_witches + tonumber(dataTable['witchesKilled']))
    dataTable['orcsKilled'] = tostring(killed_orcs + tonumber(dataTable['orcsKilled']))
    dataTable['headlessMulesKilled'] = tostring(killed_headless_mules + tonumber(dataTable['headlessMulesKilled']))
    dataTable['blackGoatsKilled'] = tostring(killed_black_goats + tonumber(dataTable['blackGoatsKilled']))
    dataTable['ouroborosKilled'] = tostring(killed_ouroboros + tonumber(dataTable['ouroborosKilled']))
    dataTable['totalTowersBought'] = tostring(totalTowersBought + tonumber(dataTable['totalTowersBought']))
    dataTable['basicTowersBought'] = tostring(towersBought[BASIC] + tonumber(dataTable['basicTowersBought']))
    dataTable['sniperTowersBought'] = tostring(towersBought[SNIPER] + tonumber(dataTable['sniperTowersBought']))
    dataTable['cannonTowersBought'] = tostring(towersBought[3] + tonumber(dataTable['cannonTowersBought']))
    dataTable['sauronTowersBought'] = tostring(towersBought[4] + tonumber(dataTable['sauronTowersBought']))
    dataTable['totalDamageDealt'] = tostring(damageDealt + tonumber(dataTable['totalDamageDealt']))
    dataTable['damageByBasic'] = tostring(damageByTowers[BASIC] + tonumber(dataTable['damageByBasic']))
    dataTable['damageBySniper'] = tostring(damageByTowers[SNIPER]  + tonumber(dataTable['damageBySniper']))
    dataTable['damageByCannon'] = tostring(damageByTowers[3] + tonumber(dataTable['damageByCannon']))
    dataTable['damageBySauron'] = tostring(damageByTowers[4] + tonumber(dataTable['damageBySauron']))

    progressFile:open('w')
    for k, v in pairs(dataTable) do
        progressFile:write(k .. '=' .. v .. ',')
    end
    progressFile:close()
end

function rememberDeck()

end