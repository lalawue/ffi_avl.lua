local avl = require("ffi_avl")

local tree =
    avl.new(
    function(a, b)
        return a - b
    end
)

local function _printTree(tag, tree)
    io.write(tag)
    local v, h = tree:first()
    repeat
        io.write(string.format("%d (h:%d), ", v, h))
        v, h = tree:next(v)
    until v == nil
    print("")
end

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
_printTree("values : ", tree)

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

tree:remove(5)
_printTree("remove 5: ", tree)
tree:remove(7)
_printTree("remove 7: ", tree)
tree:remove(3)

io.write("remove 3 walk: ")
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
