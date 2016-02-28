
if not jit or not jit.status or not jit.status() then return end

it("start and jit trace in debug hook", function()
  jit.flush()
  local called = 0
  debug.sethook(function() 
    for i=1,100 do end
    called = called+1
  end, "", 10)
  for i=1,10 do end
  debug.sethook()
  assert_eq(called, 1)
  assert((require("jit.util").traceinfo(1)))
end)

