# Crystal has the full range of numeric types, which respond to mathematical operators as expected.
# Integers
puts 2 + 2
# Floating-point values
puts 1_f32 / 4
# The boolean values
puts true && false
# Complex numbers
require "complex"
puts 1 + 1.i
# Sugar for scientific notation,
puts 1e10 % 7
# Hexadecimal and big numbers
puts 0x1000_0000_0000_0000_u64

require "big"
# As well as numbers that scale as needed
UInt64::MAX.to_big_i + UInt64::MAX

# By default, over- and underflows raise an exception
UInt64::MAX + 1 # Raises an ArithmeticOverflow exception
# However, you can get wrapped overflow behavior with &-prefixed operators
UInt64::MAX &+ 1

# All values, including all numbers, evaluate to true when used in a boolean context.
puts "truthy!" if 0
