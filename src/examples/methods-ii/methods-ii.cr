# Methods can be attached to Classes. Lets take our `Person` from the `Class`es example
class Person
  getter first_name : String, last_name : String
  # methods can be protected or private
  protected setter last_name
  getter age = 0

  def initialize(@first_name, @last_name)
  end

  # and add a method for updating their age
  def have_birthday : Nil
    puts "Happy birthday, #{@first_name}!"
    @age += 1
  end

  # As well as a simple way to get their full name.
  def name
    first_name + ' ' + last_name
  end

  bob = Person.new "Bob", "Smith"
  # Once a method is `def`ined, it can be invoked (or "called") with...
  bob.have_birthday
  # or without parentheses
  bob.have_birthday
  puts bob.age

  # lets make bob an adult.
  20.times { bob.have_birthday }

  # Instance variables can be declared at any part of the top-level of a class.
  @married = false

  # Methods may end in a question-mark. This is merely a convention, and it is said that the method "asks". The same concept applies to the exclamation mark `!`, in which case the method "shouts".
  def married?
    @married
  end

  # A method with a name ending in the `=` sign is a setter method.
  protected def married=(@married)
  end

  # The above method/instance variable combination may be shortened to only this. It is idiomatic to prefer this version.
  property? married = false
  protected setter married

  # The `self` keyword can be used to represent the enclosing type in type signiatures,
  # as well as to make explicit a call to another method on the enclosing class.
  def marry(other : self) : self
    self.last_name += '-' + other.last_name
    # Note, however, that using self to call methods on the enclosing type is optional unless the name conflicts with a top-level method name, and even then, only if the types match.
    other.last_name = last_name + '-' + other.last_name
    @married = true
    # Note the use of the protected setter method
    other.married = true
    self
  end

  alice = Person.new last_name: "Jones", first_name: "Alice"
  22.times do
    alice.have_birthday
  end
  bob.marry alice
  puts bob.name if bob.married?
end
