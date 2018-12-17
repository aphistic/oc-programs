local Trash = {}
Trash.__index = Trash

function Trash.new(transposer, side)
    local self = setmetatable({}, Trash)
    self.transposer = transposer
    self.side = side
    return self
end

return Trash