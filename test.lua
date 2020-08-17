local avl = require("ffi_avl")

local tree =
    avl.new(
    function(a, b)
        return a - b
    end
)

io.write("inserts: ")
-- insert '9, 7, 5, 3, 1'
for i = 9, 1, -2 do
    io.write(i .. ", ")
    tree:insert(i)
end
print("")

-- first '5, 1, 9'
print(string.format("count: %d, first: %d, last: %d", tree:count(), tree:first(), tree:last()))

print("insert 4, 8")
tree:insert(4)
tree:insert(8)

-- print '1, 3, 4, 5, 7, 8, 9'
io.write("values : ")
local n = tree:first()
repeat
    io.write(n)
    n = tree:next(n)
    if n then
        io.write(", ")
    end
until n == nil
print("")

-- print node height
io.write("heights: ")
local n, h = tree:first()
repeat
    io.write(h)
    n, h = tree:next(n)
    if n then
        io.write(", ")
    end
until n == nil
print("")

-- prev
io.write(" prevs : ")
local n, h = tree:last()
repeat
    io.write(n)
    n, h = tree:prev(n)
    if h then
        io.write(", ")
    end
until n == nil
print("")

io.write("remove 9, 7, 4: \t")
tree:remove(9)
tree:remove(7)
tree:remove(4)

for value, height in tree:walk() do
    io.write(string.format("%d (h:%d), ", value, height))
end
print("")

io.write("only print index [2 , 3]: \t")
for _, value in ipairs(tree:range(2, 3)) do
    io.write(value .. ", ")
end
print("")

print("-- performance")
local max_bound = 100 * 1000
local o = os.clock()
for i = 50, max_bound + 50, 1 do
    tree:insert(i)
end
print("insert " .. max_bound .. " elements: ", os.clock() - o)

o = os.clock()
for i = 50, max_bound + 50, 1 do
    tree:remove(i)
end
print("remove " .. max_bound .. " elements: ", os.clock() - o)
