local function lt(x, y)
  if x < y then return true else return false end
end

local function le(x, y)
  if x <= y then return true else return false end
end

local function gt(x, y)
  if x > y then return true else return false end
end

local function ge(x, y)
  if x >= y then return true else return false end
end

local function eq(x, y)
  if x == y then return true else return false end
end

local function ne(x, y)
  if x ~= y then return true else return false end
end


local function ltx1(x)
  if x < 1 then return true else return false end
end

local function lex1(x)
  if x <= 1 then return true else return false end
end

local function gtx1(x)
  if x > 1 then return true else return false end
end

local function gex1(x)
  if x >= 1 then return true else return false end
end

local function eqx1(x)
  if x == 1 then return true else return false end
end

local function nex1(x)
  if x ~= 1 then return true else return false end
end


local function lt1x(x)
  if 1 < x then return true else return false end
end

local function le1x(x)
  if 1 <= x then return true else return false end
end

local function gt1x(x)
  if 1 > x then return true else return false end
end

local function ge1x(x)
  if 1 >= x then return true else return false end
end

local function eq1x(x)
  if 1 == x then return true else return false end
end

local function ne1x(x)
  if 1 ~= x then return true else return false end
end

it("compare num 1, 2", function()
  local x,y = 1,2
  assert_true(x < y)
  assert_true(x <= y)
  assert_false(x > y)
  assert_false(x >= y)
  assert_false(x == y)
  assert_true(x ~= y)
end)

it("compare num constant lhs 1,1", function()
  local y = 2
  assert_true(1 < y)
  assert_true(1 <= y)
  assert_false(1 > y)
  assert_false(1 >= y)
  assert_false(1 == y)
  assert_true(1 ~= y)
end)

it("compare constant rhs 1,2", function()
  local x = 1
  assert_true(x < 2)
  assert_true(x <= 2)
  assert_false(x > 2)
  assert_false(x >= 2)
  assert_false(x == 2)
  assert_true(x ~= 2)
end)

it("compare num with func 1,2", function()
  local x,y = 1,2
  assert_true(lt(x,y))
  assert_true(le(x,y))
  assert_false(gt(x,y))
  assert_false(ge(x,y))
  assert_false(eq(y,x))
  assert_true(ne(y,x))
end)

it("compare num 2,1", function()
  local x,y = 2,1
  assert_false(x < y)
  assert_false(x <= y)
  assert_true(x > y)
  assert_true(x >= y)
  assert_false(x == y)
  assert_true(x ~= y)
end)

it("compare num constant lhs 2,1", function()
  local y = 1
  assert_false(2 < y)
  assert_false(2 <= y)
  assert_true(2 > y)
  assert_true(2 >= y)
  assert_false(2 == y)
  assert_true(2 ~= y)
end)

it("compare constant rhs 2,1", function()
  local x = 2
  assert_false(x < 1)
  assert_false(x <= 1)
  assert_true(x > 1)
  assert_true(x >= 1)
  assert_false(x == 1)
  assert_true(x ~= 1)
end)

it("compare num func paramters 2,1", function()
  local x,y = 2,1
  assert_false(lt(x,y))
  assert_false(le(x,y))
  assert_true(gt(x,y))
  assert_true(ge(x,y))
  assert_false(eq(y,x))
  assert_true(ne(y,x))
end)

it("compare num 1,1", function()
  local x,y = 1,1 
  assert_false(x < y)
  assert_true(x <= y)
  assert_false(x > y)
  assert_true(x >= y)
  assert_true(x == y)
  assert_false(x ~= y)
end)

it("compare constant lhs 1,1", function()
  local y = 1
  assert_false(1 < y)
  assert_true(1 <= y)
  assert_false(1 > y)
  assert_true(1 >= y)
  assert_true(1 == y)
  assert_false(1 ~= y)
end)

it("compare constant rhs 1,1", function()
  local x = 1
  assert_false(x < 1)
  assert_true(x <= 1)
  assert_false(x > 1)
  assert_true(x >= 1)
  assert_true(x == 1)
  assert_false(x ~= 1)
end)

it("compare num func paramters 1,1", function()
  local x,y = 1,1 
  assert_false(lt(x,y))
  assert_true(le(x,y))
  assert_false(gt(x,y))
  assert_true(ge(x,y))
  assert_true(eq(y,x))
  assert_false(ne(y,x))
end)

it("compare num 2 with func paramter", function()
  assert_true(lt1x(2))
  assert_true(le1x(2))
  
  assert_false(ge1x(2))
  assert_false(eq1x(2))
  assert_true(ne1x(2))
 
  assert_false(ltx1(2))
  assert_false(lex1(2))
  
  assert_true(gex1(2))
  assert_false(eqx1(2))
  assert_true(nex1(2))
end)

it("compare num paramter with 1 EQ", function()
  assert_false(eq1x(0))
  assert_false(eq1x(0.5))
  assert_true(eq1x(1))
  assert_false(eq1x(2))
  
  assert_false(eqx1(0))
  assert_false(eqx1(0.5))
  assert_true(eqx1(1))
  assert_false(eqx1(2))
end)

it("compare num paramter with 1 NE", function()
  assert_true(ne1x(0))
  assert_true(ne1x(0.5))
  assert_false(ne1x(1))
  assert_true(ne1x(2))
  
  assert_true(nex1(0))
  assert_true(nex1(0.5))
  assert_false(nex1(1))
  assert_true(nex1(2))
end)

it("compare num paramter gt", function()
  assert_true(gt1x(0))
  assert_true(gt1x(0.5))
  assert_false(gt1x(1))
  assert_false(gt1x(2))
  
  assert_false(gtx1(0))
  assert_false(gtx1(0.5))
  assert_false(gtx1(1))
  assert_true(gtx1(2))
end)

it("compare num paramter LT", function()
  assert_false(lt1x(0))
  assert_false(lt1x(0.5))
  assert_false(lt1x(1))
  assert_true(lt1x(2))
  
  assert_true(ltx1(0))
  assert_true(ltx1(0.5))
  assert_false(ltx1(1))
  assert_false(ltx1(2))
end)

it("compare num paramter with 1 GE", function()
  assert_true(ge1x(0))
  assert_true(ge1x(0.5))
  assert_true(ge1x(1))
  assert_false(ge1x(2))
  
  assert_false(gex1(0))
  assert_false(gex1(0.5))
  assert_true(gex1(1))
  assert_true(gex1(2))
end)

it("compare num paramter with 1 LE", function()
  assert_false(le1x(0))
  assert_false(le1x(0.5))
  assert_true(le1x(1))
  assert_true(le1x(2))
  
  assert_true(lex1(0))
  assert_true(lex1(0.5))
  assert_true(lex1(1))
  assert_false(lex1(2))
end)

it("Invalid compare types", function()
  assert_error(function()
    local a, b = 10.5, nil
    return a < b
  end)

  assert_error(function()
    local a, b = nil, 10.5
    return a < b
  end)
  
  assert_error(function()
    local a, b = true, 10.5
    return a < b
  end)
end)

it("Compare num tobit 0", function()
  for i=1,100 do
    assert(bit.tobit(i+0x7fffffff) < 0)
  end
  for i=1,100 do
    assert(bit.tobit(i+0x7fffffff) <= 0)
  end
end)

