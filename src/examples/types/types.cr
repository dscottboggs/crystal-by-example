# We've seen that variable assignment is as simple as giving a name to a piece of data
five = 5
word = "crystal"
numbers = [1, 2, 3, 4.0]

# This *looks* a lot like the sort of code we might write in a dynamic language like Ruby, Python, or JavaScript. However, looks can be decieving
puts typeof(five, word, numbers)

# Types aren't dynamic in Crystal. The exact type of every chunk of data used by your application **MUST** be known at compile-time.
# Often, as in the case of our `numbers` example, this doesn't matter.
puts numbers.sum

# Since all of the types in the numbers array (`Int32` and `Float64`) can be added together with the `+` operator, the `sum` method can be used without any shenanigans. There are restrictions on this, however, that set Crystal apart as a safer and more performant alternative to its more dynamic cousins
# Not only will this example fail, you cannot begin to run your program if theres any chance this could happen
numbers << "not a number"

# Since numbers is an array which was originally declared as an `Array(Int32|Float64)`, you can't add a string to it. So what if you wanted to define an array whose values could be either a number or some text, but you only have some numbers to put in the array literal? You have two options:
numbers_and_text : Array(Int32 | Float64 | String) = [1, 2, 3.0]
# or alternatively
text_and_numbers = [1, 2, 3.0] of Int32 | Float64 | String
text_and_numbers << "4"
# This means that when assigning a value to an empty array, its type must be explicitly specified using one of the above syntaxes
empty_for_now = [] of Int32 | Float64 | String
empty_for_now << 1.234

# In order to work with types which can't work together for a given purpose, you have to convert them to the expected type. There are two ways you may want to "sum" the `text_and_numbers` array.
# The first way is to convert the string `"4"` to an integer, and added all the values as if they were numeric. This would raise an exception at runtime if, for example, "five" were in the mix, but don't worry, it's not the only way to do this. One step at a time.
text_and_numbers.map { |n| n.to_i }.sum
# Alternately, we could convert all the numbers to strings and concatenate those with `String`'s `+` operator overload.
text_and_numbers.map { |n| n.to_s }.sum
