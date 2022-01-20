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

# print flatten([1,[[2,3]],[[4],5],6,[[7],[8]]])
# puts

def int_to_roman(int)
  case
  when int / 1000 >= 1 
    return "M" * (int / 1000) + int_to_roman(int % 1000)
  when int / 900 >= 1
    return "CM" + int_to_roman(int % 900)
  when int / 500 >= 1
    return "D" + int_to_roman(int % 500)
  when int / 400 >= 1
    return "CD" + int_to_roman(int % 400)
  when int / 100 >= 1
    return "C" * (int / 100) + int_to_roman(int % 100)
  when int / 90 >= 1
    return "XC" + int_to_roman(int % 90)
  when int / 50 >= 1
    return "L" + int_to_roman(int % 50)
  when int / 40 >= 1
    return "XL" + int_to_roman(int % 40)
  when int / 10 >= 1
    return "X" * (int / 10) + int_to_roman(int % 10)
  when int / 9 >= 1
    return "IX" + int_to_roman(int % 9)
  when int / 5 >= 1
    return "V" + int_to_roman(int % 5)
  when int / 4 >= 1
    return "IV" + int_to_roman(int % 4)
  else
    return "I" * int
  end
end

# roman_mapping = {
#   1000 => "M",
#   900 => "CM",
#   500 => "D",
#   400 => "CD",
#   100 => "C",
#   90 => "XC",
#   50 => "L",
#   40 => "XL",
#   10 => "X",
#   9 => "IX",
#   5 => "V",
#   4 => "IV",
#   1 => "I"
# }

def integer_to_roman(roman_mapping, number, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return integer_to_roman(roman_mapping, modulus, result) if quotient > 0
  end
end

# puts "int to roman: #{integer_to_roman(roman_mapping, 1992)}"

roman_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

def roman_to_integer(roman_mapping, string, result = 0)
  return result if string.empty?
  roman_mapping.keys.each do |letter|
    if string.start_with?(letter)
      result += roman_mapping[letter]
      return roman_to_integer(roman_mapping, string.sub(letter, ""), result)
    end
  end
end

puts roman_to_integer(roman_mapping, "MCMXCII")
