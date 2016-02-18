
describe("concat strings JIT", function()

-- Constant folding
it("Constant folding string buffer chain", function()
  assert_jloop("ab", function()
    local y
    for i=1,100 do y = "a".."b" end
    return y
  end)
  
  assert_jloop("ab1cd1.5", function()
    local y
    for i=1,100 do y = "ab"..(1).."cd"..(1.5) end
    return y
  end)
end)

-- Fuse conversions to strings
it("Fuse conversions to strings", function()
  assert_jloop("a100", function()
    local y
    local x = "a"
    for i=1,100 do y = x..i end
    return y
  end)
  
  assert_jloop("a100.5", function()
    local y
    local x = "a"
    for i=1.5,100.5 do y = x..i end
    return y
  end)
end)

-- Fuse string construction
it("Fuse string construction", function()
  assert_jloop("xbc", function()
    local y
    local x = "abc"
    for i=1,100 do y = "x"..string.sub(x, 2) end
    return y
  end)
end)

-- CSE, sink
it("string buffer CSE and allocation sink", function()
  assert_jloop("ab", function()
    local y
    local x = "a"
    for i=1,100 do y = x.."b" end
    return y
  end)
end)

-- CSE, two buffers in parallel, no sink
it("two string buffers in parallel CSE, no sink", function()
  local y, z
  local x1, x2 = "xx", "yy"
  for i=1,100 do y = x1.."a"..x1; z = x1.."a"..x2 end
  assert_eq(y, "xxaxx")
  assert_eq(z, "xxayy")
  x1 = "xx"
  for i=1,100 do y = x1.."a"..x1; z = x1.."b"..x1 end
  assert_eq(y, "xxaxx")
  assert_eq(z, "xxbxx")
end)

-- Append, CSE
it("Append, CSE", function()
  local y, z
  local x = "a"
  for i=1,100 do
    y = x.."b"
    y = y.."c"
  end
  assert_eq(y, "abc")
  x = "a"
  for i=1,100 do
    y = x.."b"
    z = y.."c"
  end
  assert_eq(y, "ab")
  assert_eq(z, "abc")
  x = "a"
  for i=1,100 do
    y = x.."b"
    z = y..i
  end
  assert_eq(y, "ab")
  assert_eq(z, "ab100")
end)

-- Append, FOLD
it("Append to two string buffers in parallel", function()
  assert_jloop("xy", function()
    local a, b = "x"
    for i=1,100 do b = (a.."y").."" end
    return b
  end)
end)

-- Append to buffer, sink
it("Append to string buffer, sink", function()
  assert_jloop("a"..string.rep("b", 100), function()
    local x = "a"
    for i=1,100 do x = x.."b" end
    return x
  end)
  
  assert_jloop("a"..string.rep("bc", 100), function()
    local x = "a"
    for i=1,100 do x = x.."bc" end
    return x
  end)
end)

-- Append to two buffers in parallel, no append, no sink
it("Append to two string buffers in parallel, no append, no sink", function()
  local y, z = "xx", "yy"
  for i=1,100 do y = y.."a"; z = z.."b" end
  assert_eq(y, "xx"..string.rep("a", 100))
  assert_eq(z, "yy"..string.rep("b", 100))
end)

-- Sink into side-exit
it("Sink string allocation into side-exit", function()
  local x = "a"
  local z
  for i=1,200 do
    local y = x.."b"
    if i > 100 then
      z = y..i
    end
  end
  
  assert_eq(z, "ab200")
end)

end)

