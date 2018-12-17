local Trash = {}
Trash.__index = Trash

function Trash.new(transposer, side)
    local self = setmetatable({}, Trash)
    self._transposer = transposer
    self._side = side

    self._size = transposer.getInventorySize(side)
    self._current_slot = 1

    return self
end

function Trash:dump_max(slot)
    max = self._transposer.getSlotMaxStackSize(self._side, self._current_slot)

    print("moving " .. tostring(max) .. " items from " .. slot .. " to " .. tostring(self._current_slot))

    -- self._transposer.transferItem()

end


return Trash