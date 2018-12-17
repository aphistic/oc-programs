local Inventory = {}
Inventory.__index = Inventory

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

            location = self._locations[stack.name] or {}
            location[i] = stack.size

            self._locations[stack.name] = location
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

function Inventory:lowest_count(item)
    locs = self._locations[item]
    if locs == nil then
        return nil
    end

    lowest_loc = -1
    lowest = -1
    for loc, count in pairs(locs) do
        if lowest == -1 or (count > 0 and count < lowest) then
            lowest_loc = loc
            lowest = count
        end
    end

    if lowest_loc < 0 then
        return nil
    end
    
    return (lowest_loc, lowest)
end

return Inventory