local component = require("component")
local os = require("os")
local sides = require("sides")

local Inventory = require("aphstore/inventory")
local Trash = require("aphstore/trash")

inv_names = {
    "storagedrawers:controller",
}
trash_max = 10000
trash_names = {
    "extrautils2:trashchest",
}

inv_side = -1
trash_side = -1
for i=0,5 do
    inv_name = component.transposer.getInventoryName(i)
    for _, iname in ipairs(inv_names) do
        if inv_name == iname then
            inv_side = i
            break
        end
    end

    for _, iname in ipairs(trash_names) do
        if inv_name == iname then
            trash_side = i
            break
        end
    end
end

if inv_side < 0 then
  print("Could not find inventory")
  os.exit()
end

inv = Inventory.new(component.transposer, inv_side)
trash = Trash.new(component.transposer, trash_side)

print("Refreshing inventory")
inv:refresh()

junk = inv:has_over(trash_max)
for item, count in pairs(junk) do
    print(item .. " is junk, have " .. tostring(count))

    count = inv:lowest_count(item)
    if loc ~= nil then
        count = inv:count_at(count)
        print("lowest: " .. tostring(count))
    end
end