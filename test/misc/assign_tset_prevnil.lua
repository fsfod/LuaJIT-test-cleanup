context("multi assign globals", function()

it("multi assign globals/tset prev nil", function()
  a, b, c = 0, 1
  assert_eq(a, 0)
  assert_eq(b, 1)
  assert_eq(c, nil)
  
  a, b = a+1, b+1, a+b
  assert_eq(a, 1)
  assert_eq(b, 2)
end)

it("multi assign globals with single value", function()
  a = 1
  b = 1
  c = 1
  a, b, c = 0
  assert_eq(a, 0)
  assert_eq(b, nil)
  assert_eq(c, nil)
end)

after(function()
  a = nil
  b = nil
  c = nil
end)

end)