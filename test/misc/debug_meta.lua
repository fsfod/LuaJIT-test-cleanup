
context("debug.getinfo", function()
local what

local function mm(a, b)
  local dbg = debug.getinfo(1)
  what = dbg.namewhat == "metamethod" and dbg.name or
					  dbg.namewhat.." "..(dbg.name or "?")
end

local mt = {
  __index = mm,
  __newindex = mm,
  __eq = mm,
  __add = mm,
  __sub = mm,
  __mul = mm,
  __div = mm,
  __mod = mm,
  __pow = mm,
  __unm = mm,
  __len = mm,
  __lt = mm,
  __le = mm,
  __concat = mm,
  __call = mm,
}

it("debug.getinfo in Lua table metamethods", function()
  local t = setmetatable({}, mt)
  
  local x = t.x; assert_eq(what, "__index")
  t.x = 1; assert_eq(what, "__newindex")
  
  local x = t();		assert_eq(what, "local t")
  local x = t + t;	assert_eq(what, "__add")
  local x = t - t;	assert_eq(what, "__sub")
  local x = t * t;	assert_eq(what, "__mul")
  local x = t / t;	assert_eq(what, "__div")
  local x = t % t;	assert_eq(what, "__mod")
  local x = t ^ t;	assert_eq(what, "__pow")
  local x = -t;		  assert_eq(what, "__unm")
  local x = t..t;		assert_eq(what, "__concat")
end)

it("debug.getinfo in Lua table comparison metamethods", function()
  local t = setmetatable({}, mt)
  local t2 = setmetatable({}, mt)
  
--local x = #t;		ck("__len") -- Not called for tables 
  local x = t == t2;	assert_eq(what, "__eq")
  local x = t ~= t2;	assert_eq(what, "__eq")
  local x = t < t2;	assert_eq(what, "__lt")
  local x = t > t2;	assert_eq(what, "__lt")
  local x = t <= t2;	assert_eq(what, "__le")
  local x = t >= t2;	assert_eq(what, "__le")
end)

it("debug.getinfo in userdata metamethods", function()
  local u = newproxy()
  debug.setmetatable(u, mt)

  local x = u.x;		assert_eq(what, "__index")
  u.x = 1;		assert_eq(what, "__newindex")
  
  local x = u();	assert_eq(what, "local u")
  local x = u + u;	assert_eq(what, "__add")
  local x = u - u;	assert_eq(what, "__sub")
  local x = u * u;	assert_eq(what, "__mul")
  local x = u / u;	assert_eq(what, "__div")
  local x = u % u;	assert_eq(what, "__mod")
  local x = u ^ u;	assert_eq(what, "__pow")
  local x = -u;		assert_eq(what, "__unm")
  local x = #u;		assert_eq(what, "__len")
  local x = u..u;	assert_eq(what, "__concat")
end)

it("debug.getinfo in userdata comparison metamethods", function()
  local u = newproxy()
  local u2 = newproxy()
  debug.setmetatable(u, mt)
  debug.setmetatable(u2, mt)

  local x = u == u2;	assert_eq(what, "__eq")
  local x = u ~= u2;	assert_eq(what, "__eq")
  local x = u < u2;	assert_eq(what, "__lt")
  local x = u > u2;	assert_eq(what, "__lt")
  local x = u <= u2;	assert_eq(what, "__le")
  local x = u >= u2;	assert_eq(what, "__le")
end)

end)
