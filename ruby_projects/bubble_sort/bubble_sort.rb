def bubble_sort(input_array)
  #iterate across array and compare each value to the next, swap if right is larger
  array = input_array
  loop do
    unsorted = 0
    array.each_with_index do |val, index|
      unless index == array.length - 1
        if val > array[index + 1]
          temp = array[index + 1]
          array[index] = temp
          array[index + 1] = val
          unsorted += 1
        end
      end
    end
    if unsorted == 0
      break
    end
  end
  array
end

print bubble_sort([4,3,78,2,0,2])
puts