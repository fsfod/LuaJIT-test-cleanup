
describe("alias_alloc", function()

it("alias alloc self assignment", function()
  local t = {1}
  local x
  for i=1,100 do
    local v = {i}
    t[1] = v[1]
    x = v[1]
  end
  assert_eq(x, 100)
  assert_eq(t[1], 100)
end)

it("alias alloc table 2", function()
  local t = {1}
  local x,y
  for i=1,100 do
    local v = {i}
    local w = {i+1}
    x = v[1]
    y = w[1]
  end
  assert_eq(x, 100)
  assert_eq(y, 101)
end)

it("alias alloc metatable", function()
  local mt = {}
  local t = setmetatable({}, mt)
  local x
  for i=1,100 do
    local v = {}
    setmetatable(v, getmetatable(t))
    assert(getmetatable(v) == mt)
  end
end)

-- See also sink_alloc.lua
it("alias alloc ", function()
  local x,k={1,2},{3,4}
  for i=1,100 do x = {x[1]+k[1], x[2]+k[2]} end
  assert_eq(x[1], 301)
  assert_eq(x[2], 402)
end)

-- FLOAD for tab.asize/tab.array crossing NEWREF.
it("alias alloc FLOAD NEWREF", function()
  local t = {1}
  for i=1,100 do
    local v = {}
    local w = {}
    v[1] = t[1]
    w[1] = t[1]
  end
end)

end)

