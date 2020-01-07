# Crystal offers the classic `while` loop...
x = 0
while (x += 1) <= 10
  puts x
end
# ...which honors the the classic `break` keyword; as well as the `next` keyword, which skips the rest of the current loop iteration
File.write "example", "some\n5\nlines\nof\ntext\n"
File.open "example" do |file|
  number = Float64::INFINITY
  count = 0
  while line = file.gets(chomp: true)
    if n = line.to_i? || line.to_f?
      number = n.to_f
      break
    end
    count += 1
  end
  # Note that `count` should only be 1 because the loop stops as soon as it encounters a numeric value
  puts number, count
end

# There is also a simple `loop` statement
loop do
  x -= 1
  next if x.even?
  break if x <= 0
  puts x
end

# The `while`-loop's logic can be inverted using an `until` loop
args = ["cmd", "-o", "-x", "param"]
until args.empty?
  arg = args.shift
  do_something_with arg
end

# One can also loop a specific number of times
3.times do
  STDOUT.puts "Hip hip!"
  STDERR.puts "Hooray!"
end

# Or on specific values
8.to 16 do |i|
  puts "#{i} is between 8 and 16"
end

# The last two examples use the block argument syntax, which will be our next topic and a topic we will cover again later

# Note the lack of a `for`-loop construct. We'll come back to that.
