# frozen_string_literal: true

class ConnectFour
  def initialize(minimum = 0, maximum = 6)
    @minimum = minimum
    @maximum = maximum
  end

  def play_game
    # introduction
    # do stuff
  end

  def player_input(min, max)
    loop do
      user_input = gets.chomp
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d+$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} or #{max} in a column that is not full."
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end
end
