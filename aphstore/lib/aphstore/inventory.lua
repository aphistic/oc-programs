local Inventory = {}
Inventory.__index = Inventory

setmetatable(Inventory, {
    _call = function (cls, ...)
        return cls.new(...)
    end,
})

function Inventory.new(transposer, side)
    local self = setmetatable({}, Inventory)
    self._transposer = transposer
    self._side = side
    self._size = transposer.getInventorySize(side)

    self._totals = {}
    self._locations = {}

    return self
end

function Inventory:reset()
    self._totals = {}
    self._locations = {}
end

function Inventory:refresh()
    self:reset()

    for i = 1, self:size() do
        stack = self._transposer.getStackInSlot(self._side, i)
        if stack ~= nil then
            self._totals[stack.name] = (self._totals[stack.name] or 0) + stack.size
            self._locations[stack.name] = (self._locations[stack.name] or {})[i] = stack.size
        end
    end
end

function Inventory:size()
    return self._size
end

function Inventory:has_over(amount)
    res = {}

    for item, count in pairs(self._totals) do
        if count > amount then
            res[item] = count
        end
    end

    return res
end

return Inventory