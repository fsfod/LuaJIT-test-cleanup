
it("fori loop type coercion string to number", function()
  local n = 1
  local x = 0
  for i=1,20 do
    for j=n,100 do x = x + 1 end
    if i == 13 then n = "2" end
  end
  assert_eq(x, 1993)
end)

it("fori loop type coercion string to number", function()
  local n = 1
  local x = 0
  for i=1,20 do
    for j=n,100 do x = x + 1 end
    if i == 10 then n = "2" end
  end
  assert_eq(x, 1990)
end)

it("fori loop bad type coercion", function()
  local function f()
    local n = 1
    local x = 0
    for i=1,20 do
      for j=n,100 do x = x + 1 end
      if i == 10 then n = "x" end
    end
  end
  assert_error(f)
end)

