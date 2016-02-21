
local getmetatable, setmetatable = getmetatable, setmetatable

-- 1. Store with same ref and same value. All stores in loop eliminated.
it("dse IR field - same ref and same value", function()
  assert_jloop(nil, function()
    local mt = {}
    local t = {}
    for i=1,100 do
      setmetatable(t, mt)
      assert(getmetatable(t) == mt)
      setmetatable(t, mt)
      assert(getmetatable(t) == mt)
    end
    assert_eq(getmetatable(t), mt)
  end)
end)

-- 2. Store with different ref and same value. All stores in loop eliminated.
it("dse IR field - diff ref and same value", function()
  assert_jloop(nil, function()
    local mt = {}
    local t1 = {}
    local t2 = {}
    for i=1,100 do
      setmetatable(t1, mt)
      assert(getmetatable(t1) == mt)
      setmetatable(t2, mt)
      assert(getmetatable(t2) == mt)
    end
    assert_eq(getmetatable(t1), mt)
    assert_eq(getmetatable(t2), mt)
  end)
end)

-- 3. Store with different ref and different value. Cannot eliminate any stores.
it("dse IR field - diff ref and dif value", function()
  assert_jloop(nil, function()
    local mt1 = {}
    local mt2 = {}
    local t1 = {}
    local t2 = {}
    for i=1,100 do
      setmetatable(t1, mt1)
      assert(getmetatable(t1) == mt1)
      setmetatable(t2, mt2)
      assert(getmetatable(t2) == mt2)
    end
    assert_eq(getmetatable(t1), mt1)
    assert_eq(getmetatable(t2), mt2)
  end)
end)

-- 4. Store with same ref and different value. 2nd store remains in loop.
it("dse IR field - same ref and diff value", function()
  assert_jloop(nil, function()
    local mt1 = {}
    local mt2 = {}
    local t = {}
    for i=1,100 do
      setmetatable(t, mt1)
      assert(getmetatable(t) == mt1)
      setmetatable(t, mt2)
      assert(getmetatable(t) == mt2)
    end
    assert_eq(getmetatable(t), mt2)
  end)
end)

-- 5. Store with same ref, different value and aliased loads.
--    Cannot eliminate any stores.
it("dse IR field - same ref and same value, alised loads", function()
  assert_jloop(nil, function()
    local mt1 = {}
    local mt2 = {}
    local t1 = {}
    local t2 = t1
    for i=1,100 do
      setmetatable(t1, mt1)
      assert(getmetatable(t2) == mt1)
      setmetatable(t1, mt2)
      assert(getmetatable(t2) == mt2)
    end
    assert_eq(getmetatable(t1), mt2)
  end)
end)

