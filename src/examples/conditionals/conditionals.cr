# Crystal provides the standard if/else branching mechanism
if 7 % 2 == 0
  puts "7 is even"
else
  puts "7 is odd"
end

# Branches may return a value as well
puts "7 is " + if 7 % 2 == 0
                 "even"
               else
                 "odd"
               end
# There is also the unless keyword, meaning "if not"
unless 8 % 5 == 0
  puts "8 is not divisible by 5"
end
# branch expressions can also be put after a one-line expression
puts "8 is divisible by 4" if 8 % 4 == 0

# Assignment can be done inside an if expression.
if (num = 9) < 0
  puts num, "is negative"
elsif num < 10
  puts num, "has 1 digit"
else
  puts num, "has multiple digits"
end
# Note the use of the elsif keyword for handling more than 2 cases.
