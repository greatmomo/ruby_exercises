def stock_picker(input_array)
  puts "Input Array: #{input_array}"
  difference = 0
  result = []
  input_array.each_with_index do |low, low_index|
    input_array[low_index..-1].each_with_index do |high, high_index|
      if high - low > difference
        difference = high - low
        result[0] = low_index
        result[1] = low_index + high_index
      end
    end
  end
  result
end

best_stocks = stock_picker([17,3,6,9,15,8,6,1,10])
print "Buy on day #{best_stocks[0] + 1} and sell on day #{best_stocks[1] + 1}\n"