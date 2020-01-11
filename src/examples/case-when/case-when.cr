# When one is evaluating a large number of possible matches against a single value, one can use the `case`...`when` expression.
case rand 1..10
when 1 then puts "one"
when 2
  puts "two"
when 3, 5, 7
  puts "odd in the middle"
  # Note that one can separate multiple matches for a single statement on a line.
when 4, 6 then puts "even in the middle"
  # Also, one can match ranges to single numbers. This is not a special syntax.
when 8..9 then puts "large single-digit"
else           puts "two-digit number"
end

# Case statements compare based on the `===` operator, which idiomatically is a "match" operator in Crystal. Ranges "match" any of their members.
pp! (1..3 === 2)

# Case statements can also be used with methods other than the standard `===` match operator.
require "http"
http_response = HTTP::Client::Response.new rand 200...600
case http_response.status
when .success? then puts "Request OK"
when .redirect?
  location = http_response.headers["Location"]
  puts "redirected to #{location}"
when 400..403, 405 then puts "uh-oh"
when 404           then puts "not found"
when 500           then puts "server error"
else                    puts "other error"
end
