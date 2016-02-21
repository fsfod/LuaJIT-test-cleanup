
describe("Function constants overflow(SLOWTEST)", function()

--if not os.getenv("SLOWTEST") then return end

it("Function number constants overflow", function()
  local t = { "local x\n" }
  for i=2,65537 do t[i] = "x="..i..".5\n" end
  assert_not_nil(loadstring(table.concat(t)))
  t[65538] = "x=65538.5"
  assert_nil(loadstring(table.concat(t)))
end)

it("Function GC constants overflow", function()
  local t = { "local x\n" }
  for i=2,65537 do t[i] = "x='"..i.."'\n" end
  assert_not_nil(loadstring(table.concat(t)))
  t[65538] = "x='65538'"
  assert_nil(loadstring(table.concat(t)))
end)

end)
