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
  
  def my_select
  end

  def my_all?
  end

  def my_any?
  end

  def my_none?
  end

  def my_count
  end

  def my_map
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

numbers = [1, 2, 3, 4, 5]
numbers.my_each_with_index do |value, index|
  puts "value = #{value}, index = #{index}"
end
