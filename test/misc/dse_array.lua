context("dse table array", function()

local assert = assert

-- Same value ----------------------------------------------------------------

-- 1. Store with same ref and same value.
--    2nd store eliminated. All stores in loop eliminated.
it("dse table array - 1 tab same idx and value", function()
  assert_jloop(11, function()
    local t = { 1, 2 }
    for i=1,100 do
      t[1] = 11
      assert(t[1] == 11)
      t[1] = 11
      assert(t[1] == 11)
    end
    return t[1]
  end)
end)

-- 2. Store with different tab, same idx and same value.
--    All stores in loop eliminated.
it("dse table array - 2 tab same idx and value", function()
  assert_jloop(11, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    for i=1,100 do
      t1[1] = 11
      assert(t1[1] == 11)
      t2[1] = 11
      assert(t2[1] == 11)
    end   
    assert_eq(t1[1], 11)
    assert_eq(t2[1], 11)
    return t1[1]
  end)
end)

-- 3. Store with same tab, different const idx and same value.
--    All stores in loop eliminated. Also disambiguated.
it("dse table array - 1 tab diff idx and same value", function()
  assert_jloop(nil, function()
    local t = { 1, 2 }
    for i=1,100 do
      t[1] = 11
      assert(t[1] == 11)
      t[2] = 11
      assert(t[2] == 11)
    end
    assert_eq(t[1], 11)
    assert_eq(t[2], 11)
  end)
end)

-- 4. Store with different tab, different const idx and same value.
--    All stores in loop eliminated. Also disambiguated.
it("dse table array - 2 tab diff idx and same value", function()
  assert_jloop(nil, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    for i=1,100 do
      t1[1] = 11
      assert(t1[1] == 11)
      t2[2] = 11
      assert(t2[2] == 11)
    end
    assert_eq(t1[1], 11)
    assert_eq(t2[2], 11)
  end)
end)

-- 5. Store with different tab, different non-const idx and same value.
--    All stores in loop eliminated. Not disambiguated (but not needed).
it("dse table array - 2 tab non-const idx and same value", function()
  assert_jloop(nil, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    local k = 1
    for i=1,100 do
      t1[k] = 11
      assert(t1[k] == 11)
      t2[2] = 11
      assert(t2[2] == 11)
    end
    assert_eq(t1[1], 11)
    assert_eq(t2[2], 11)
  end)
end)

-- 6. Store with same ref, same value and aliased loads.
--    2nd store eliminated. Not disambiguated (but not needed).
it("dse table array - 2 tab aliased and same idx aliased loads", function()
  assert_jloop(11, function()
    local t1 = { 1, 2 }
    local t2 = t1
    for i=1,100 do
      t1[1] = 11
      assert(t2[1] == 11)
      t1[1] = 11
      assert(t2[1] == 11)
    end
    return t1[1]
  end)
end)

-- Different value -----------------------------------------------------------

-- 7. Store with same ref and different value.
--    1st store eliminated. All stores in loop eliminated.
it("dse table array - 1 tab same idx and diff value", function()
  assert_jloop(22, function()
    local t = { 1, 2 }
    for i=1,100 do
      assert(true)
      t[1] = 11
      assert(t[1] == 11)
      t[1] = 22
      assert_true(t[1] == 22)
    end
    return t[1]
  end)
end)

-- 8. Store with different tab, same idx and different value.
--    Cannot eliminate any stores (would need dynamic disambiguation).
it("dse table array - 2 tab same idx and diff value", function()
  assert_jloop(nil, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    for i=1,100 do
      assert(true)
      t1[1] = 11
      assert(t1[1] == 11)
      t2[1] = 22
      assert(t2[1] == 22)
    end
    assert_eq(t1[1], 11)
    assert_eq(t2[1], 22)
  end)
end)

-- 9. Store with same tab, different const idx and different value.
--    Disambiguated. All stores in loop eliminated.
it("dse table array - 1 tab diff idx and diff value", function()
  assert_jloop(nil, function()
    local t = { 1, 2 }
    for i=1,100 do
      assert(true)
      t[1] = 11
      assert(t[1] == 11)
      t[2] = 22
      assert(t[2] == 22)
    end
    assert_eq(t[1], 11)
    assert_eq(t[2], 22)
  end)
end)

-- 10. Store with different tab, different const idx and different value.
--     Disambiguated. All stores in loop eliminated.
it("dse table array - 2 tab diff idx and diff value", function()
  assert_jloop(nil, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    for i=1,100 do
      assert(true)
      t1[1] = 11
      assert(t1[1] == 11)
      t2[2] = 22
      assert(t2[2] == 22)
    end
    assert_eq(t1[1], 11)
    assert_eq(t2[2], 22)
  end)
end)

-- 11. Store with different tab, different non-const idx and different value.
--     Cannot eliminate any stores (would need dynamic disambiguation).
it("dse table array - 2 tab dyn idx and diff value", function()
  assert_jloop(nil, function()
    local t1 = { 1, 2 }
    local t2 = { 1, 2 }
    local k = 1
    for i=1,100 do
      assert(true)
      t1[k] = 11
      assert(t1[k] == 11)
      t2[2] = 22
      assert(t2[2] == 22)
    end
    assert_eq(t1[1], 11)
    assert_eq(t2[2], 22)
  end)
end)

-- 12. Store with same ref, different value and aliased loads.
--     Cannot eliminate any stores (would need dynamic disambiguation).
it("dse table array - 2 tab aliased same idx and diff value", function()
  assert_jloop(22, function()
    local t1 = { 1, 2 }
    local t2 = t1
    for i=1,100 do
      assert(true)
      t1[1] = 11
      assert(t2[1] == 11)
      t1[1] = 22
      assert(t2[1] == 22)
    end
    return t1[1]
  end)
end)

-- CALLL must inhibit DSE.
it("dse table array - CALLL load from table inhibits DSE", function()
  assert_jloop(nil, function()
    local a,b
    local t = {1,2}
    for i=1,100 do
      t[2]=nil
      a=#t
      t[2]=2
      b=#t
    end
    assert_eq(a, 1)
    assert_eq(b, 2)
  end)
end)

end)
