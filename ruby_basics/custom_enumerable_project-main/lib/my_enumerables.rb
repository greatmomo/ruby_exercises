# frozen_string_literal: true

module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    each do |value|
      yield [value, i]
      i += 1
    end
  end

  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    arr = []

    each do |value|
      arr << value if block.call(value)
    end
    arr
  end

  def my_all?(&block)
    return to_enum(:my_all?) unless block_given?

    each do |value|
      return false unless block.call(value)
    end
    true
  end

  def my_any?(&block)
    return to_enum(:my_and?) unless block_given?

    each do |value|
      return true if block.call(value)
    end
    false
  end

  def my_none?(&block)
    return to_enum(:my_none?) unless block_given?

    each do |value|
      return false if block.call(value)
    end
    true
  end

  def my_count(arg = nil, &block)
    count = 0
    if block_given?
      each { |value| count += 1 if block.call(value) }
    elsif !arg.nil?
      each { |value| count += 1 if value == arg }
    else
      each { |_value| count += 1 }
    end
    count
  end

  def my_map(&block)
    return to_enum(:my_map) unless block_given?

    arr = []

    each do |value|
      arr << block.call(value)
    end
    arr
  end

  def my_inject(arg1 = nil, arg2 = nil, &block)
    accumulator = nil
    arr = instance_of?(Range) ? to_a : self
    accumulator = arg1 if !arg1.nil? && arg2.nil? && block_given?
    accumulator = arg1 if !arg1.nil? && !arg2.nil?
    if accumulator.nil?
      accumulator = first
      (0..arr.size - 2).each do |i|
        accumulator = block.call(accumulator, arr[i + 1]) if block_given?
        accumulator = accumulator.send arg1, arr[i + 1] unless block_given?
      end
    else
      (0..arr.size - 1).each do |i|
        accumulator = block.call(accumulator, arr[i]) if block_given?
        accumulator = accumulator.send arg2, arr[i] unless block_given?
      end
    end
    accumulator
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

    each do |value|
      yield(value, index)
    end
  end
end

numbers = [11, 22, 33, 4, 5]
# control = numbers.inject {|sum, n| sum + n}
symbol = numbers.my_inject(:+)
argsym = numbers.my_inject(10, :+)
block = numbers.my_inject { |sum, n| sum + n }
argblock = numbers.my_inject(10) { |sum, n| sum + n }
puts "symbol = #{symbol}, argsym = #{argsym}, block = #{block}, argblock = #{argblock}"
