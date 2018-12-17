local component = require("component")
local os = require("os")
local side = require("side")

inv_names = {
    "storagedrawers:controller",
}
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

-- testing
 
 
--inv_side = 3
if inv_side < 0 then
  print("Could not find inventory")
  os.exit()
end
 
inv_size = component.transposer.getInventorySize(inv_side)
print("Using inventory in side " .. tostring(inv_side) .. " with size " .. tostring(inv_size))
if trash_side >= 0 then
  print("Using trash on side " .. tostring(trash_side))
else
  print("Couldn't find trash to use")
end
 
item_aggregates = {}
for i=1,inv_size do
  stack = component.transposer.getStackInSlot(inv_side, i)
  if stack ~= nil then
    item_count = item_aggregates[stack.name] or 0
    item_count = item_count + stack.size
    item_aggregates[stack.name] = item_count
    print(stack.name .. " - " .. tostring(item_count))
  end
end
 
for k, v in pairs(item_aggregates) do
  print(k .. " - " .. tostring(v))
end