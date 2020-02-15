# A range is for enumerating or iterating over a set of values defined by
# their start and end point. It is represented by the beginning value,
# followed by either two or three dots, followed by the end value.

# For example, a range representing all the numbers up to and including 10
one_through_ten = 1..10
puts one_through_ten.join ", "
# Or all the numbers between 1 and 10
puts (1...10).join ", "

# This doesn't just apply to numbers, though, it can be any type which defines the `#succ` method.
puts ('a'..'z').join ", "

# Even custom types
class CharWithNumber
  property char : Char
  property number : Int32

  def initialize(@char = 'a', @number = 0); end

  def succ
    self.class.new @char.succ, @number.succ
  end

  def to_s(io)
    io << to_s
  end

  def to_s
    "#{char}/#{number}"
  end

  def inspect(io)
    to_s io
  end

  def <(other)
    char < other.char
  end
end

puts (CharWithNumber.new..CharWithNumber.new 'c', 2).join '\n'

# The beginning or the end may be left off the range, indicating it is an
# infinite range. For example, this prints all the perfect squares up to
# 400, along with their square roots
(1..).take_while do |n|
  puts "#{n} squared is #{n * n}"
  n * n <= 400
end
