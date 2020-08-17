
# About

ffi_avl.lua was a avl list implement, using cdata to conjunction Lua values.

# Usage

```lua
--[[
   list will keep only one value instance,
   for value <-> node mapping
]]

local tree = require("ffi_avl").new(function(a, b)
    return a - b
end)

-- insert '9, 7, 5, 3, 1'
for i = 9, 1, -2 do
    tree:insert(i)
end

-- from first
local n = tree:first()
while n do
    n = tree:next(n)
end

-- from last
n = tree:last()
while n do
    n = tree:prev(n)
end

-- remove 9
tree:remove(9)

-- print 5, 3
for _, value in ipairs(tree:range(2, 3)) do
    io.write(value .. ", ")
end
print("")

-- print '1, 3, 5, 7' value with height
for value, height in tree:walk() do
    io.write(string.format("%d (h:%d), ", value, height))
end
print("")
```

# Performance

MacBook Pro 2017, 3.1 GHz Intel Core i5

```
-- performance
insert 100000 elements:         0.198528
remove 100000 elements:         0.038852
```