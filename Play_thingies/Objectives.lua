--[[
    A simple class to deal with objectivess
    TODO:
    - adicionar um arquivo para a paleta de cores
]]

Objectives = Class{}

-- anchor variables for changing and recording the progress on objectives
local newObjective = {false, false, false} -- a signal for each objective
local anchors = {0, 0, 0} -- an anchor for each objective, too

-- local variables for the images of the button, so they aren't created every single change
local upImage = love.graphics.newImage('Graphics/Buttons/button_objectives_up.png')
local downImage = love.graphics.newImage('Graphics/Buttons/button_objectives_down.png')

function Objectives:init()
    -- variable for killing
    killed_enemies = 0
    killed_elfs = 0
    killed_imps = 0
    killed_genies = 0
    killed_land_men = 0
    killed_dinos = 0
    killed_boitatas = 0
    killed_centaurs = 0
    killed_medusas = 0
    killed_old_sages = 0
    killed_witches = 0
    killed_orcs = 0
    killed_headless_mules = 0
    killed_black_goats = 0
    killed_ouroboros = 0

    -- boolean to show, or not, the objectives
    self.showObjectives = true

    --initial pos of the objectives, as long with its width and height when the objectives are not being shown
    self.x, self.y = 10, 120
    self.width, self.height = 170, 25

    -- all the objectives in the game
    self.objectives = {
        {
            -- killing related objectives
            amount = math.random(5, 30) * 5,
            text = language.objectives.killEnemies,
            var = {'killed_enemies', 0},
            bounty = 50
        },
        {
            -- damage-giving related objectives
            amount = math.random(30, 100) * 10,
            text = language.objectives.dealDamage,
            var = {'damage_dealt', 0},
            bounty = 50
        },
        {
            -- surviving related objectives
            amount = math.random(30),
            text = language.objectives.surviveWaves,
            var = {'wave', 0},
            bounty = 50 
        },
        {
            -- kiling boos
            amount = math.random(10, 100),
            text = language.objectives.killElfs,
            var = {'killed_elfs', 0},
            bounty = 40
        },
        {
            -- kiling meanie boos
            amount = math.random(10, 100),
            text = language.objectives.killImps,
            var = {'killed_imps', 0},
            bounty = 40
        },
        {
            -- kiling vampirins
            amount = math.random(10, 100),
            text = language.objectives.killGenies,
            var = {'killed_genies', 0},
            bounty = 40
        },
        {
            -- kiling esqueletin
            amount = math.random(10, 100),
            text = language.objectives.killLandMen,
            var = {'killed_land_men', 0},
            bounty = 40
        },
        {
            -- kiling dinossaurin
            amount = math.random(10, 100),
            text = language.objectives.killDinos,
            var = {'killed_dinos', 0},
            bounty = 40
        },
        {
            -- kiling cobrin
            amount = math.random(10, 100),
            text = language.objectives.killBoitatas,
            var = {'killed_boitatas', 0},
            bounty = 40
        }
    }

    -- current objectives table
    self.selectedObjectives = {}

    -- assign objectives to the table, removing the chosen ones from the larger table of objectives
    self:assignObjective(1)
    self:assignObjective(2)
    self:assignObjective(3)

    -- a simple button to show objectives
    self.showObjectivesButton = Button({
        x = self.x + 138,
        y = self.y - 39,
        image = upImage,
        OnClick = function() if self.showObjectives then self.showObjectives = false else self.showObjectives = true end end
    })
end

function Objectives:update()
    self.showObjectivesButton:update(dt)

    if self.showObjectives then
        self.showObjectivesButton.image = upImage
    else
        self.showObjectivesButton.image = downImage
    end

    -- if any objective has been complete, change it
    self:changeObjective()
    
    -- update the current objectives; if a new one is chosen, give the current value of its correspondent variable to ts anchor
    -- so players don't start an objective already half completed
    for i, objective in ipairs(self.selectedObjectives) do
        if objective ~= nil then
            if objective.var[1] == 'killed_enemies' then
                if newObjective[i] then
                    anchors[i] = killed_enemies
                    newObjective[i] = false
                end
                objective.var[2] = killed_enemies - anchors[i]
            elseif objective.var[1] == 'damage_dealt' then
                if newObjective[i] then
                    anchors[i] = damageDealt
                    newObjective[i] = false
                end
                objective.var[2] = damageDealt - anchors[i]
            elseif objective.var[1] == 'wave' then
                if newObjective[i] then
                    anchors[i] = wave
                    newObjective[i] = false
                end
                objective.var[2] = wave - anchors[i]
            elseif objective.var[1] == 'killed_elfs' then
                if newObjective[i] then
                    anchors[i] = killed_elfs
                    newObjective[i] = false
                end
                objective.var[2] = killed_elfs - anchors[i]
            elseif objective.var[1] == 'killed_imps' then
                if newObjective[i] then
                    anchors[i] = killed_imps
                    newObjective[i] = false
                end
                objective.var[2] = killed_imps - anchors[i]
            elseif objective.var[1] == 'killed_genies' then
                if newObjective[i] then
                    anchors[i] = killed_genies
                    newObjective[i] = false
                end
                objective.var[2] = killed_genies - anchors[i]
            elseif objective.var[1] == 'killed_land_men' then
                if newObjective[i] then
                    anchors[i] = killed_land_men
                    newObjective[i] = false
                end
                objective.var[2] = killed_land_men - anchors[i]
            elseif objective.var[1] == 'killed_dinos' then
                if newObjective[i] then
                    anchors[i] = killed_dinos
                    newObjective[i] = false
                end
                objective.var[2] = killed_dinos - anchors[i]
            elseif objective.var[1] == 'killed_boitatas' then
                if newObjective[i] then
                    anchors[i] = killed_boitatas
                    newObjective[i] = false
                end
                objective.var[2] = killed_boitatas - anchors[i]
            end
        end
    end
end

function Objectives:changeObjective()
    for i, objective in ipairs(self.selectedObjectives) do
        if objective ~= nil then
            if objective.var[2] >= objective.amount then
                global_money = global_money + math.floor((objective.bounty * moneyMultiplier))
                self:assignObjective(i)
                newObjective[i] = true
            end
        end
    end
end

function Objectives:assignObjective(objectiveNum)
    local objectiveId = math.random(#self.objectives)
    self.selectedObjectives[objectiveNum] = self.objectives[objectiveId]
    table.remove(self.objectives, objectiveId)
end

function Objectives:render()
    -- render the top part
    love.graphics.setColor(142 / 255, 72 / 255, 25 / 255)
    love.graphics.rectangle('fill', self.x - 5, self.y - 36, self.width, self.height)
    love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)
    love.graphics.rectangle('line', self.x - 5, self.y - 36, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    self.showObjectivesButton:render()
    love.graphics.print(language.objectives.name, self.x, self.y - 34, 0, 3 / 4)

    -- render the objectives
    if self.showObjectives then
        love.graphics.setColor(142 / 255, 72 / 255, 25 / 255)
        love.graphics.rectangle('fill', self.x - 5, self.y - 12, 170, 130)
        love.graphics.setColor(1, 1, 1)
        for i, objective in ipairs(self.selectedObjectives) do
            love.graphics.print(objective.text[1] .. math.floor(objective.amount - objective.var[2]) .. objective.text[2], self.x, self.y + 45 * (i - 1), 0, 1 / 2)
            if i < 3 then
                love.graphics.setColor(107 / 255, 54 / 255, 18 / 255)
                love.graphics.line(self.x - 5, self.y + 30 + 45 * (i - 1), self.x + 165, self.y + 30 + 45 * (i - 1))
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
end