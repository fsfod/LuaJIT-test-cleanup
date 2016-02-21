
it("debug.traceback for coroutines", function()
  local co = coroutine.create(function()
    local x = nil
    local y = x.x
  end)
  assert_false(coroutine.resume(co))
  assert_not_nil(debug.traceback(co))
end)

