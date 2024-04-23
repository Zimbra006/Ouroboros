--[[
    uma classe para lidar com a tediosa tarefa de criar botões
]]

Button = Class{}

function Button:init(params)
    self.x = params.x
    self.y = params.y

    self.message = params.message or ''

    self.image = params.image or 'none'

    self.width = params.width or self.image:getWidth()
    self.height =  params.height or self.image:getHeight()

    if self.image ~= 'none' then
        self.scale = 0.72
    else
        self.scale = 1
    end

    self.OnClick = params.OnClick or function() end

end

function Button:update(dt)
    if mouse_x > self.x + self.width * (1 - self.scale) / 2 and mouse_x < self.x + self.width - self.width * (1 - self.scale) / 2 and mouse_y > self.y + self.height * (1 - self.scale) / 2 and mouse_y < self.y + self.height + self.height * (1 - self.scale) / 2 then
        if self.image ~= 'none' then
            self.scale = 0.83
        end
        if mouseWasClicked then
            self.OnClick()
        end
    elseif self.image ~= 'none' then
        self.scale = 0.72
    end
end

function Button:render()
    love.graphics.draw(self.image, self.x + self.width / 2, self.y + self.height / 2, 0, self.scale, self.scale, self.width / 2, self.height / 2)
    love.graphics.print(self.message, self.x + self.width / 2 - 8, self.y + self.height / 2, 0, self.scale * 5 / 2, self.scale * 5 / 2, #self.message / 4 * 26, 14)
end