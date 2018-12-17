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

function Trash:dump_max(side, slot)
    trash_slot = self._current_slot
    self._current_slot = trash_slot + 1
    max = self._transposer.getSlotMaxStackSize(self._side, trash_slot)

    print("moving " .. max .. " items from " .. side .. "#" .. slot .. " to " .. self._side .. "#" .. trash_slot)

    -- self._transposer.transferItem()

end


return Trash