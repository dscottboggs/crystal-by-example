# Just about every modern programming language has some sort of construct for storing a list, or *array*, of data.
# In crystal, this usually takes the form of the fixed-size `Array` generic type. A *generic* type is a type that can work with a bunch of different types of data, as long as that data implements a certain interface.
some_array = [1, 2, 3]
array_of_strings = ["a", "list", "of", "strings"]

# Sometimes, we want to specify the type of an array
matrix : Array(Array(Floa64)) = Array(Array(Floa64)).new
# you can also specify the type of an array using the `of` keyword. This list is an Array(Number) which means it is allowed to store any number.
numbers = [1, 2, 3, 4] of Number
# If we had just specified the array literal, we could not append this float value.
numbers << 3.5
puts numbers
# The `of Type` notation is *required* when assigning an empty list.
empty = [] of Nil

# arrays can be added together...
puts [1, 2] + [3, 4]
# ...multiplied...
puts [5, 6] * 3
# ...subtracted from each other...
puts [1, 2, 3, 4] - [2, 3]
# ...and much more
puts [1, 2, 3, 4] & [3, 4, 5, 6]
args = ["-a", "-f", "file.txt"]
while arg = args.shift?
  puts arg
end
puts [1, 1, 2, 3, 3, 3, 5].uniq
