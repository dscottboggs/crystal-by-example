# Arrays, as well as most other *collection* types include the powerful `Enumerable` mixin.
ARGV.each_with_index do |arg, index|
  puts '$' + index.to_s + '=' + arg
end
(1..10).select(&.even?).map { |n| n // 2 }

# `Enumerable` provides a complete replacement for the common for-loop found in other languages.
sum = 0
print "enter a positive number: "
requested = (gets || 10).to_u32
requested.times do |count|
  sum += count + 1
end
puts "the sum of all the natural numbers up to #{requested} was #{sum}"

# As well as `foreach` or `for-in` loops
words = ["Crystal", "is", "great"]
words.each { |word| puts word }

# And contains most common map-reduce primatives as well, to achieve the most readable and efficient data manipulation possible
# todo blah blah blah
