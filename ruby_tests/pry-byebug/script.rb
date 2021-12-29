#require 'pry-byebug'

def yell_greeting(string)
  name = string

  #binding.pry

  name = name.upcase
  greeting = "WASSAP, #{name}!"
  puts greeting
end

yell_greeting("bob")

def method1
  method2
end
def method2
  puts invalid_variable
end
method1