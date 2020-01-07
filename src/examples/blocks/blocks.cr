# Methods can accept a block of code that is executed with the `yield` keyword. For example:
def twice
  yield
  yield
end

twice do
  puts "Hello!"
end

# To define a method that receives a block, simply use yield inside it and the compiler will know. You can make this more evident by declaring a dummy block argument named `&`.
def twice(&)
  yield
  yield
end

# To invoke a method and pass a block, you use `do...end` or `{ ... }`. All of these are equivalent
twice() do
  puts "Hello!"
end

twice do
  puts "Hello!"
end

twice { puts "Hello!" }

# The difference between using `do...end` and `{ ... }` is that `do...end` binds to the left-most call, while `{ ... }` binds to the right-most call. For example
# this...
foo bar do
  something
end

# ...is the same as
foo(bar) do
  something
end

# While this...
foo bar { something }

# ...is the same as
foo(bar { something })

# The reason for this is to allow creating Domain Specific Languages (DSLs) using `do...end` to have them be read as plain English.

# For example, this
open file "foo.cr" do
  something
end

# is the same as this
open(file("foo.cr")) do
end

# -----

# The standard-library's `loop` statement that we learned about in the previous example is as simple as this
while true
  yield
end
