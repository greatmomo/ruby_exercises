# frozen_string_literal: true

class ConnectFour
  def initialize(minimum = 0, maximum = 6)
    @minimum = minimum
    @maximum = maximum
  end

  def play_game
  end

  def player_input(min, max)
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end
end
