
-- Don't fuse i+101 on x64.
-- Except if i is sign-extended to 64 bit or addressing is limited to 32 bit.
it("no fuse signed index(jit,x64)", function()
  assert_jloop(1, function()
    local t = {}
    for i=-100,-1 do t[i+101] = 1 end
    return t[1]
  end)
end)

