--[[
    everything related to the image of the current map
]]

Map = Class{}

require('Play_thingies.Map_thingies.map_sections')

-- global const to store the size of a quad
TILE_SIZE = 64

function Map:init()
    -- creates the visual archive for map creation
    self.spritesheet = love.graphics.newImage('Graphics/Map/blocks.png')
    self.blocks = geneQuads(self.spritesheet, TILE_SIZE)

    -- variables for the map size
    self.mapWidth = 17
    self.mapHeight = 8

    self.x, self.y = (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2, (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2
    self.widthPixels, self.heightPixels = self.mapWidth * TILE_SIZE, self.mapHeight * TILE_SIZE

    -- creates the map, initially filling it with empty spaces
    self.map = {}
    for y = 1, self.mapHeight do
        self.map[y] = {}
        for x = 1, self.mapWidth do
            self.map[y][x] = EMPTY
        end
    end

    -- thorugh procedural generation, creates a map based in 5 different areas, each of which has 10 possible layouts
    -- therefore, it has 100000 possible maps
    self.randomMapPicker = math.random(1, 10)

    for y = 1, 3 do
        for x = 1, 8 do
            self.map[y][x] = area1[self.randomMapPicker][y][x]
        end
    end

    self.randomMapPicker = math.random(1, 10)

    for y = 4, self.mapHeight do
        local x_max = 8
        if y >= 6 then x_max = 5 end
        for x = 1, x_max do
            self.map[y][x] = area2[self.randomMapPicker][y - 3][x]
        end
    end

    self.randomMapPicker = math.random(1, 10)

    for y = 4, self.mapHeight do
        local x_min = 9
        if y >= 6 then x_min = 6 end
        for x = x_min, 11 do
            self.map[y][x] = area3[self.randomMapPicker][y - 3][x - (x_min - 1)]
        end
    end

    self.randomMapPicker = math.random(1, 10)

    for y = 1, self.mapHeight do
        local x_min = 9
        if y >= 4 then x_min = 12 end
        for x = x_min, 14 do
            self.map[y][x] = area4[self.randomMapPicker][y][x - (x_min - 1)]
        end
    end

    self.randomMapPicker = math.random(1, 10)

    for y = 1, self.mapHeight do
        for x = 15, self.mapWidth do
            self.map[y][x] = area5[self.randomMapPicker][y][x - 14]
        end
    end

    -- puts everything into a canvas so it doesn't ask much of the draw function
    self.canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(self.canvas)
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            local block = self.map[y][x]
            love.graphics.draw(self.spritesheet, self.blocks[block], (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
        end
    end
    love.graphics.setCanvas()
end

-- returns a block in a specified pixel position
function Map:blockAt(x, y)
    return {
        x = math.ceil((x - (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2) / TILE_SIZE),
        y = math.ceil((y - (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2) / TILE_SIZE),
        id = self.map[math.ceil((y - (VIRTUAL_HEIGHT - FIELD_HEIGHT - 128) / 2) / TILE_SIZE)][math.ceil((x - (VIRTUAL_WIDTH - FIELD_WIDTH + 96) / 2) / TILE_SIZE)]
    }
end

function Map:render()
    love.graphics.draw(self.canvas, self.x, self.y)
end