local Trash = {}
Trash.__index = Trash

setmetatable(Trash, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function Trash.new(transposer, side)
    local self = setmetatable({}, Trash)
    self.transposer = transposer
    self.side = side
    return self
end

return Trash