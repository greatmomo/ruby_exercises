# frozen_string_literal: true

def merge_sort(arr)
  return arr if arr.length <= 1

  arr_left = merge_sort(arr[0...arr.length / 2].dup)
  arr_right = merge_sort(arr[arr.length / 2..arr.length].dup)

  combine(arr_left, arr_right)
end

def combine(arr_left, arr_right)
  ret_arr = []

  while !arr_left.empty? && !arr_right.empty?
    ret_arr.push(arr_left.first < arr_right.first ? arr_left.shift : arr_right.shift)
  end
  ret_arr += arr_left unless arr_left.empty?
  ret_arr += arr_right unless arr_right.empty?
  ret_arr
end

arr = [4, 3, 5, 1, 2, 7, 6, 2, 5, 12, 33, 1, 7, 2]
print merge_sort(arr)
puts
