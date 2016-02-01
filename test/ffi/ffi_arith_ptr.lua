local ffi = require("ffi")

ffi.cdef[[
typedef struct { int a,b,c; } foo1_t;
void free(void *);
void *malloc(size_t);
struct incomplete;
]]

describe("ffi pointer arith", function()

it("ptr compare", function()
  local a = ffi.new("int[10]")
  local p1 = a+0
  p1[0] = 1;
  p1[1] = 2;
  assert_eq(a[0], 1)
  assert_eq(a[1], 2)
  assert_eq(a, p1)
  assert_false(a ~= p1)
  assert_lte(p1, a)
  assert_lte(a, p1)
  assert_false(p1 < a)
  assert_false(a < p1)
  assert_ne(a, nil)
  assert_false(a == nil)
  assert_ne(p1, nil)
  assert_false(p1 == nil)

  local p2 = a+2
  p2[0] = 3;
  p2[1] = 4;
  assert_eq(a[2], 3)
  assert_eq(a[3], 4)
  assert_eq(p2 - p1, 2)
  assert_eq(p1 - p2, -2)
  assert_ne(p1, p2)
  assert_false(p1 == p2)
  assert_lt(p1, p2)
  assert_gt(p2, p1)
  assert_false(p1 > p2)
  assert_false(p2 < p1)
  assert_lte(p1, p2)
  assert_gte(p2, p1)
  assert_false(p1 >= p2)
  assert_false(p2 <= p1)

  local p3 = a-2
  assert_eq(p3[2], 1)
  assert_eq(p3[3], 2)
  local p4 = a+(-3)
  assert_eq(p4[5], 3)
  assert_eq(p4[6], 4)
  
  -- different qualifiers are ok
  local b = ffi.cast("const int *", a+5)
  assert_eq(b - a, 5)
end)

it("ptr errors", function()
  local a = ffi.new("int[10]")
  local p2 = a+2
  local p1 = a+0
  -- bad: adding two pointers or subtracting a pointer
  assert_error(function(p1, p2) return p1 + p2 end, p1, p2)
  assert_error(function(p1) return 1 - p1 end, p1)
  assert_error(function(p1) return 1.5 - p1 end, p1)
  -- bad: subtracting different pointer types
  assert_error(function(p1) return p1 - ffi.new("char[1]") end, p1)
end)

it("ptr cast", function()
  local p1 = ffi.cast("void *", 0)
  local p2 = ffi.cast("int *", 1)
  assert_eq(p1, p1)
  assert_eq(p2, p2)
  assert_ne(p1, p2)
  assert_eq(p1, nil)
  assert_ne(p2, nil)
end)

it("function ptr cmp", function()
  local f1 = ffi.C.free
  local f2 = ffi.C.malloc
  local p1 = ffi.cast("void *", f1)
  assert_eq(f1, f1)
  assert_ne(f1, nil)
  assert_ne(f1, f2)
  assert_eq(p1, f1)
  assert_ne(p1, f2)
  assert(f1 < f2 or f1 > f2)
  assert_error(function(f1) return f1 + 1 end, f1)
end)

it("struct array ptr", function()
  local s = ffi.new("foo1_t[10]")
  local p1 = s+3
  p1.a = 1; p1.b = 2; p1.c = 3
  p1[1].a = 4; p1[1].b = 5; p1[1].c = 6
  assert_eq(s[3].a, 1)
  assert_eq(s[3].b, 2)
  assert_eq(s[3].c, 3)
  
  assert_eq(s[4].a, 4)
  assert_eq(s[4].b, 5)
  assert_eq(s[4].c, 6)
  local p2 = s+6
  assert_eq(p2 - p1, 3)
  assert_eq(p1 - p2, -3)
end)

it("incomplete struct ptr", function()
  local mem = ffi.new("int[1]")
  local p = ffi.cast("struct incomplete *", mem)
  assert_error(function(p) return p+1 end, p)
  local ok, err = pcall(function(p) return p[1] end, p)
  assert(not ok and err:match("size.*unknown"))
end)

end)
