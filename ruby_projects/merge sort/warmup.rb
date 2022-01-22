# frozen_string_literal: true

def fibs(val)
  return 0 if val == 1

  left = 0
  right = 1
  tmp = 0
  (2..val).each do
    tmp = right
    right += left
    left = tmp
  end
  right
end

def fibs_rec(val)
  val <= 1 ? val : fibs_rec(val - 1) + fibs_rec(val - 2)
end

# puts fibs(gets.chomp.to_i)
puts fibs_rec(gets.chomp.to_i)
