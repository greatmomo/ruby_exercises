def fibs(n)
  return 0 if n == 1
  left = 0
  right = 1
  tmp = 0
  (2..n).each do |i|
    tmp = right
    right = right + left
    left = tmp
  end
  return right
end


def fibs_rec(n)
  return n <= 1 ? n : fibs_rec(n-1) + fibs_rec(n-2)
end


# puts fibs(gets.chomp.to_i)
puts fibs_rec(gets.chomp.to_i)
