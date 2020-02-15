# *Method*s (sometimes called functions or procedures) are reusable blocks of code. Methods may optionally accept positional or named parameters, and may return one or more values.
def greeting(person)
  return "Hey, " + person + '!'
end

# Once a method is defined, it can be *call*ed
puts greeting "Crystal programmer"

# The `return` keyword is optional -- the last line of the method will be returned if the `return` keyword is not encountered earlier. Arguments can receive default values
def greeting(person = "you")
  "Hey, #{person}!"
end

puts greeting

# An argument may also optionally have a *type-restriction* and an *external name*. If a type-restriction is present, the program will refuse to compile (and hence run at all) if the restriction is violated.
def greeting(for person : String = "you")
  "Hey, #{person}!"
end

# If an external name is present, it may be used to identify the argument at the call-site.
puts greeting for: "Arnold"

# This code would not compile due to the type restriction.
{% skip_file %}
greeting for: 123456

# Please note that later definitions of a method override previous definitions: only the last `def greeting` counts.
