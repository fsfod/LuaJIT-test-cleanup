context("gcstep", function()

local function testgc(func)
  collectgarbage()
  local oc = gcinfo()
  func()
  local nc = gcinfo()
  return oc, nc
end

--FIXME: should t not be declared outside the loop since it has no use making it dead code
it("gcstep TNEW", function()
  local oc, nc = testgc(function()
    for i=1,10000 do
      local t = {}
    end
  end)
  assert_lt(nc, oc*4, "GC step missing")
end)

it("gcstep TDUP", function()
  local oc, nc = testgc(function()
    for i=1,10000 do
      local t = {1}
    end
  end)
  assert_lt(nc, oc*4, "GC step missing")
end)

it("gcstep FNEW", function()
  local oc, nc = testgc(function()
    for i=1,10000 do
      local function f() end
    end
  end)
  assert_lt(nc, oc*4, "GC step missing")
end)

it("gcstep CAT", function()
  local oc, nc = testgc(function()
    for i=1,10000 do
      local s = "x"..i
    end
  end)
  assert_lt(nc, oc*4, "GC step missing")
end)

end)

