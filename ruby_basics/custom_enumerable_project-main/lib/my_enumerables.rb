module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    for value in self do
      yield [value, i]
      i += 1
    end
  end
  
  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    arr = []

    for value in self do
      arr << value if block.call(value)
    end
    arr
  end

  def my_all?(&block)
    return to_enum(:my_all?) unless block_given?

    for value in self do
      return false unless block.call(value)
    end
    true
  end

  def my_any?(&block)
    return to_enum(:my_and?) unless block_given?

    for value in self do
      return true if block.call(value)
    end
    false
  end

  def my_none?(&block)
    return to_enum(:my_none?) unless block_given?

    for value in self do
      return false if block.call(value)
    end
    true
  end

  def my_count(arg=nil, &block)
    count = 0
    if block_given?
      self.each { |value| count += 1 if block.call(value) }
    elsif arg != nil
      self.each { |value| count += 1 if value == arg }
    else
      self.each { |value| count += 1 }
    end
    count
  end

  def my_map(&block)
    return to_enum(:my_map) unless block_given?

    arr = []

    for value in self do
      arr << block.call(value)
    end
    arr
  end
  
  def my_inject
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    for value in self do
      yield(value, index)
    end
  end
end

numbers = [11, 22, 33, 4, 5]
output = numbers.my_none? {|value| value > 10}
puts "output = #{output}"
