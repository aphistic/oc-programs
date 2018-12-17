local component = require("component")
local os = require("os")
local side = require("side")

inv_names = {
    "storagedrawers:controller",
}
trash_names = {
    "extrautils2:trashchest",
}


scanner_side = -1
trash_side = -1
for i=0,5 do
    inv_name = component.transposer.getInventoryName(i)
    for _, iname = ipairs(inv_names) do
        if inv_name == iname then
            inv_side = i
        end
    end

    for _, iname = ipairs(trash_names) do
        if inv_name == iname then
            trash_side = i
        end
    end
end

-- testing
 
 
--scanner_side = 3
if scanner_side < 0 then
  print("Could not find storage scanner")
  os.exit()
end
 
inv_size = component.transposer.getInventorySize(scanner_side)
print("Using storage scanner in side " .. tostring(scanner_side) .. " with size " .. tostring(inv_size))
if trash_side >= 0 then
  print("Using trash on side " .. tostring(trash_side))
else
  print("Couldn't find trash to use")
end
 
item_aggregates = {}
for i=1,inv_size do
  stack = component.transposer.getStackInSlot(scanner_side, i)
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