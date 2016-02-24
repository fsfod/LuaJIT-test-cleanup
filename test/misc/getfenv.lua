
it("getfenv global environment and coroutines", function()
  local x
  local function f()
    x = getfenv(0)
  end
  local co = coroutine.create(f)
  local t = {}
  debug.setfenv(co, t)
  for i=1,50 do f() f() f() end
  assert_eq(x, getfenv(0))
  coroutine.resume(co)
  assert_eq(x, t)
end)

