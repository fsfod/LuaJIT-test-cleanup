
local tinsert = table.insert
local assert = assert

describe("table.insert", function()

it("table.insert append", function()
  local t = {}
  for i=1,100 do t[i] = i end
  for i=1,100 do tinsert(t, i) end
  
  assert_eq(#t, 200)
  assert_eq(t[100], 100)
  assert_eq(t[200], 100)
end)

it("table.insert append colocated array", function()
  local t = {1, 2, 3}
  for i=1,100 do t[i] = i end
  for i=1,100 do tinsert(t, i) end
  
  assert_eq(#t, 200)
  assert_eq(t[10], 10)
  assert_eq(t[16], 16)
  assert_eq(t[100], 100)
  assert_eq(t[200], 100)
end)

it("table.insert index", function()
  local t = {}
  for i=1,200 do t[i] = i end
  for i=101,200 do tinsert(t, i, i) end
  
  assert_eq(#t, 300)
  assert_eq(t[101], 101)
  assert_eq(t[200], 200)
  assert_eq(t[300], 200)
end)

it("table.insert index shift", function()
  local t = {}
  tinsert(t, 5)
  tinsert(t, 6)
  tinsert(t, 1, 4)
  assert_eq(#t, 3)
  assert_eq(t[1], 4)
  assert_eq(t[2], 5)
  assert_eq(t[3], 6)
  
  --check colocated array
  t = {1, 2, nil}
  tinsert(t, 1, 3)
  assert_eq(#t, 3)
  assert_eq(t[1], 3)
  assert_eq(t[2], 1)
  assert_eq(t[3], 2)
end)

end)

