# Strings are immutable collections of UTF-8 codepoints.
puts "some text"
# They can be concatenated with other strings using the plus operator
puts "some" + " text"
# Formatted with the percent/modulus operator
puts "some four-digit number %04d" % 123
# And interpolated
data = "embedded data"
puts "some text with #{data}."
# They can also take span more than one line
puts "some \
        very long \
        text"
# There is also an alternative delimiter syntax.
puts %[a "string" with "lots" of 'quotes' inside]
# Curly, square, and angle braces can be used in this way, as well as parentheses.
