--[[
    main file from the game Ouroboros

    Made by:
     -Anna Clara Oliveira Monteiro (annacomonteiro)
     -Guilherme Amazonas Böhme (Zimbra006)

    July / 2020
]]

Class = require ('Util.class')
push = require ('Util.push')
require('Util.Languages')
require('Util.Util')
require('Util.Button')
require('One_file_screens.Options')
require('One_file_screens.Menu')
require('Play_thingies.Play')
require('One_file_screens.Death')
require('One_file_screens.Stats')
require('One_file_screens.Instructions')
require('Grimoire_thingies.grimoire')

-- initializes the pseudo-random number generator
math.randomseed(os.time())

-- virtual sizes of the screen, so it can zoom in or out
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 1366, 768

-- global consts for the actual size of the screen
width, height = love.window.getDesktopDimensions(1)

-- size of the original map
FIELD_WIDTH, FIELD_HEIGHT = 1088, 512

-- set a zoom filter so things don't look blurry
love.graphics.setDefaultFilter('nearest', 'nearest')

-- initilizes the file to which write things like highscore, which cards have been unlocked, etc, if it doesn't exists already
progressFile = love.filesystem.newFile('ouroborosPlayerProgress.txt')
local fileExistence = love.filesystem.getInfo('ouroborosPlayerProgress.txt')
local opened, error = true, 'none'
if fileExistence == nil then
    local opened, error = progressFile:open('w')
    progressFile:write('gamesPlayed=0,highscore=0,totalEnemiesKilled=0,elfsKilled=0,impsKilled=0,geniesKilled=0,landMenKilled=0,dinosKilled=0,boitatasKilled=0,centaursKilled=0,medusasKilled=0,oldSagesKilled=0,witchesKilled=0,orcsKilled=0,headlessMulesKilled=0,blackGoatsKilled=0,ouroborosKilled=0,totalTowersBought=0,basicTowersBought=0,sniperTowersBought=0,cannonTowersBought=0,sauronTowersBought=0,totalDamageDealt=0,damageByBasic=0,damageBySniper=0,damageByCannon=0,damageBySauron=0,')
    progressFile:close()
end

function love.load()
    --sets to where save the game files
    love.filesystem.setIdentity('Ouroboros')

    -- initializes the font
    love.graphics.setFont(love.graphics.newFont("Graphics/Font/Alkhemikal.ttf", 32))
    
    -- initializes the main musics for the game
    main_music = love.audio.newSource('Audio/Music/Relaxing_Green_Nature_David_Fesliyan.mp3', 'stream')
    gaming_music = love.audio.newSource('Audio/Music/Deep_Meditation_David_Fesliyan.mp3', 'stream')

    -- zooms the screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, width, height, {
        fullscreen = true
    })

    -- title of the screen
    love.window.setTitle('Ouroboros')

    -- icon for the screen
    local iconCanvas = love.graphics.newCanvas(64, 64)
    local iconImage = love.graphics.newImage('Graphics/Details/logo.png')

    love.graphics.setCanvas(iconCanvas)
    love.graphics.draw(iconImage, 0, 0)
    love.graphics.setCanvas()

    local logo = iconCanvas:newImageData()

    love.window.setIcon(logo)

    -- global variable to check for clicks
    mouseWasClicked = false

    -- current state of gaming
    game_state = 'grimoire'
    
    -- the main screens of the game
    options_screen = Options()
    menu_screen = Menu()
    grimoire_screen = Grimoire()
    play_screen = Play()
    death_screen = Death()
    stats_screen = 'none'
    instructions_screen = Instructions()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- checks for a click
function love.mousereleased(x, y, button)
    if button == 1 then
        mouseWasClicked = true
    end
end

function love.update(dt)
    if game_state == 'play' or game_state == 'pause' then
        main_music:stop()
        gaming_music:play()
    else
        gaming_music:stop()
        main_music:play()
    end
    -- global mouse position variables
    mouse_x = love.mouse.getX() * VIRTUAL_WIDTH / width
    mouse_y = love.mouse.getY() * VIRTUAL_HEIGHT / height

    if game_state == 'menu' then
        menu_screen:update(dt)
    elseif game_state == 'instructions' then
        instructions_screen:update(dt)
    elseif game_state == 'play' or game_state == 'pause' then
        play_screen:update(dt)
    elseif game_state == 'game over' then
        death_screen:update(dt)
    elseif game_state == 'grimoire' then
        grimoire_screen:update(dt)
    elseif game_state == 'stats' then
        stats_screen:update(dt)
    elseif game_state == 'options' then
        options_screen:update(dt)
    end

    -- updates mouseWasClicked so it's only true at the moment it was clicked
    mouseWasClicked = false
end

function love.draw()
    push:start() 

    -- nice color on the background
    if game_state ~= 'game over' then
        love.graphics.clear(9 / 255, 47 / 255 , 51 / 255, 1)
    else
        love.graphics.clear(0, 0, 0, 1)
    end
    
    if game_state == 'menu' then
        menu_screen:render()
    elseif game_state == 'instructions' then
        instructions_screen:render()
    elseif game_state == 'play' or game_state == 'pause' then
        play_screen:render()
    elseif game_state == 'game over' then
        death_screen:render()
    elseif game_state == 'grimoire' then
        grimoire_screen:render()
    elseif game_state == 'stats' then
        stats_screen:render()
    elseif game_state == 'options' then
        options_screen:render()
    end

    push:finish()

    if not opened then
        love.graphics.print(error, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
    end
end