
-- 1.
it("fwd tnew HREF -> niltv: folded", function()
  assert_jloop(nil, function()
    local x = 2
    for i=1,100 do
      local t = {}	-- TNEW: DCE
      x = t.foo		-- HREF -> niltv: folded
    end
    assert_nil(x)
  end)
end)

-- 2.
it("fwd tdup HREF -> niltv: folded", function()
  assert_jloop(nil, function()
    local x = 2
    for i=1,100 do
      local t = {1}	-- TDUP: DCE
      x = t.foo		-- HREF -> niltv: folded
    end
    assert_nil(x)
  end)
end)

-- 3.
it("fwd tnew NEWREF + HSTORE", function()
  assert_jloop(11, function()
    local x = 2
    for i=1,100 do
      local t = {}
      t[1] = 11		-- NEWREF + HSTORE
      x = t[1]		-- AREF + ALOAD, no forwarding, no fold
    end
    return x
  end)
end)

-- 4. HREFK not eliminated. Ditto for the EQ(FLOAD(t, #tab.hmask), k).
it("fwd tnew HREFK + HLOAD: store forwarding", function()
  assert_jloop(11, function()
    local x = 2
    for i=1,100 do
      local t = {}
      t.foo = 11		-- NEWREF + HSTORE
      x = t.foo		-- HREFK + HLOAD: store forwarding
    end
    return x
  end)
end)

-- 5. HREFK not eliminated. Ditto for the EQ(FLOAD(t, #tab.hmask), k).
it("fwd tdup HREFK + non-nil HLOAD: folded", function()
  assert_jloop(11, function()
    local x = 2
    for i=1,100 do
      local t = {foo=11}	-- TDUP
      x = t.foo		-- HREFK + non-nil HLOAD: folded
    end
    return x
  end)
end)

-- 6.
it("fwd tdup ASTORE aliasing no fold", function()
  assert_jloop(11, function()
    local x = 2
    local k = 1
    for i=1,100 do
      local t = {[0]=11}	-- TDUP
      t[k] = 22		-- AREF + ASTORE aliasing
      x = t[0]		-- AREF + ALOAD, no fold
    end
    return x
  end)
end)

-- 7.
it("fwd tnew setmetatable", function()
  assert_jloop(nil, function()
    local setmetatable = setmetatable
    local mt = { __newindex = function(t, k, v)
      assert(k == "foo")
      assert(v == 11)
    end }
    for i=1,100 do
      local t = setmetatable({}, mt)
      t.foo = 11
    end
  end)
end)

