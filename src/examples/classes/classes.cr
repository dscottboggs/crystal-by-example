# All of the examples so far have been just lines of code dropped into a file,
# like a shell script. While you can write Crystal like this, for anything more
# than the smallest weekend project or the most basic educational excercises, you'll
# want to split your code up into a more well-organized structure. Crystal offers
# 3 ways to namespace your code -- Classes, Structs and Modules. We'll go over Classes
# and Modules now, but Structs can wait til later.

# A class is a blueprint from which individual objects are created. As an example, consider a Person class. You declare a class like this:
class Person
end

# You create an instance of a class by invoking new on that class. Here, person is an instance of Person.
person = Person.new

# We can't do much with person, so let's add some concepts to it. An object is a collection
# of data which responds to some methods. Since we're using a `Person` as an example,
# lets give the person a name and an age. We'll come back to methods and what those are in a
# moment. Note that all types must start with a capital letter, and variables that are members
# of an object begin with the `@` symbol.
class Person
  @name = "Alice"
  @age = 0
end

# We still can't do much with this because this information is only available within the class. However, we can make it available publicly with the `getter`, `setter`, or `property` macros
class Person
  property name
  getter age
end

# Now we can work with a `Person`'s data
person = Person.new
person.name = "Bob"
puts person.age

# There is also a shortcut for defining the type and/or default data on a `property`, `getter`, or `setter`.
class Automobile
  property capacity : UInt8
  getter number_of_doors = 2_u8
  property color : String

  # A value not assigned by default *must* be assigned in an overload of the special `initialize` method
  def initialize(capacity, @color)
    # Naming a method starting with the `@` symbol is the same as setting the instance variable with
    # the same name to that value
    @capacity = capacity
  end
end
