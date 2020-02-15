# The yield expression is similar to a call and can receive arguments. For example:
def twice
  yield 1
  yield 2
end

twice do |i|
  puts "Got #{i}"
end

# A curly braces notation is also available:
twice { |i| puts "Got #{i}" }

# You can yield many values:
def many
  yield 1, 2, 3
end

many do |x, y, z|
  puts x + y + z
end

# Each block variable has the type of every yield expression in that position. For example:
def some
  yield 1, 'a'
  yield true, "hello"
  yield 2, nil
end

some do |first, second|
  puts typeof(first)
  puts typeof(second)
end

# This means that you must determine the type of a value at runtime before calling a method on it,
# if all yielded types don't implement the method.

# -----

# A block can specify less than the arguments yielded...
def many
  yield 1, 2, 3
end

many do |x, y|
  puts x + y
end

# ...but it's an error at compile-time specifying more block arguments than those yielded:
def two_times
  yield
  yield
end

{% skip_file %}

two_times do |i| # Error: too many block arguments
end
