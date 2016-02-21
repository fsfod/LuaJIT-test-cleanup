
it("dualnum - Positive overflow", function()
  local x = 0
  for i=2147483446,2147483647,2 do x = x + 1 end
  assert_eq(x, 101)
end)

it("dualnum - Negative overflow", function()
  local x = 0
  for i=-2147483447,-2147483648,-2 do x = x + 1 end
  assert_eq(x, 101)
end)

it("dualnum - SLOAD with number to integer conversion", function()
  local k = 1
  local a, b, c = 1/k, 20/k, 1/k
  for i=1,20 do
    for j=a,b,c do end
  end
end)

it("dualnum - min max result", function()
  local function fmin(a, b)
    for i=1,100 do a = math.min(a, b) end
    return a
  end
  local function fmax(a, b)
    for i=1,100 do a = math.max(a, b) end
    return a
  end
  assert_eq(fmin(1, 3), 1)
  assert_eq(fmin(3, 1), 1)
  assert_eq(fmin(-1, 3), -1)
  assert_eq(fmin(3, -1), -1)
  assert_eq(fmin(-1, -3), -3)
  assert_eq(fmin(-3, -1), -3)
  assert_eq(fmax(1, 3), 3)
  assert_eq(fmax(3, 1), 3)
  assert_eq(fmax(-1, 3), 3)
  assert_eq(fmax(3, -1), 3)
  assert_eq(fmax(-1, -3), -1)
  assert_eq(fmax(-3, -1), -1)
end)