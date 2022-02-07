#lib/calculator.rb

class Calculator
  def add(a,b,c = nil)
    if c
      a + b + c
    else
      a + b
    end
  end

  def multiply(a,b)
    a * b
  end
end
