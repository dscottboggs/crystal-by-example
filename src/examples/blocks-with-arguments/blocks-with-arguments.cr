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

# A block can specify less than the arguments yielded:
def many
  yield 1, 2, 3
end

many do |x, y|
  puts x + y
end

# It's an error at compile-time specifying more block arguments than those yielded:
def twice
  yield
  yield
end

twice do |i| # Error: too many block arguments
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
