def bottles_of_beer(n)
  if n <= 0
    puts 'no more bottles of beer on the wall'
  else
    puts "#{n} bottles of beer on the wall"
    bottles_of_beer(n-1)
  end
end

# bottles_of_beer(10)

def fibonacci(n)
  if n == 0 || n == 1
    return n
  else
    return fibonacci(n - 1) + fibonacci(n - 2)
  end
end

# puts "#{fibonacci(5)}"
# puts "#{fibonacci(6)}"

def flatten(arr)
  ret = []
  arr.each do |value|   
    if value.kind_of?(Array)
      ret.push(*flatten(value))
    else
      ret.push(value)
    end
  end
  ret
end

print flatten([1,[[2,3]],[[4],5],6,[[7],[8]]])
puts
