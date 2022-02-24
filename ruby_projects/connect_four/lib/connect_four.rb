# frozen_string_literal: true

require_relative 'player.rb'

class ConnectFour
  def initialize(minimum = 0, maximum = 6, height = 6, symbol_p1 = '☭', symbol_p2 = '☪')
    @minimum = minimum
    @maximum = maximum
    @height = height
    @board = [[],[],[],[],[],[],[]]
    @players = [Player.new(symbol_p1), Player.new(symbol_p2)]
  end

  def players
    @players
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

      puts "Input error! Please enter a number between #{min} or #{max}."
    end
  end

  def player_turn(current_player)
    input = player_input(@minimum, @maximum) - 1
    unless @board[input].length >= @height
      @board[input] << players[current_player - 1].symbol
      current_player = current_player == 1 ? 2 : 1
    else
      puts "Input error! The selected column is full!"
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def board_full?
  end
end
