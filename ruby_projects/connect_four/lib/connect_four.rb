# frozen_string_literal: true

require_relative 'player.rb'

class ConnectFour
  def initialize(minimum = 0, maximum = 6, height = 6, symbol_p1 = '☭', symbol_p2 = '☪')
    @minimum = minimum
    @maximum = maximum
    @height = height
    @board = [[],[],[],[],[],[],[]]
    @players = [Player.new(symbol_p1), Player.new(symbol_p2)]
    @current_player = 1
  end

  def players
    @players
  end

  def current_player
    @current_player
  end

  def play_game
    # introduction
    player_turn until board_full? || game_over?
  end

  def player_turn
    input = player_input(@minimum, @maximum) - 1
    unless @board[input].length >= @height
      @board[input] << players[current_player - 1].symbol
      @current_player = toggle_player
    else
      puts "Input error! The selected column is full!"
    end
  end

  def toggle_player
    @current_player = @current_player == 1 ? 2 : 1
  end

  def player_input(min, max)
    loop do
      user_input = gets.chomp
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d+$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} or #{max}."
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def board_full?
    @board.each do |column|
      return false unless column.length >= 6
    end
    true
  end

  def game_over?(col, row)
    return true if scan_vertical(col, row) >= 4 || scan_horizontal(col, row) >= 4 || scan_up_right(col, row) >= 4 || scan_up_left(col, row) >= 4
    false
  end

  def scan_vertical(col, row)
    row -= 1 while row >= 0 && @board[col][row] == players[current_player - 1].symbol
    row += 1
    count = 0
    while row <= @maximum && @board[col][row] == players[current_player - 1].symbol do
      count += 1
      row += 1
    end
    count
  end

  def scan_horizontal(col, row)
    col -= 1 while col >= 0 && @board[col][row] == players[current_player - 1].symbol
    col += 1
    count = 0
    while col <= @maximum && @board[col][row] == players[current_player - 1].symbol do
      count += 1
      col += 1
    end
    count
  end

  def scan_up_right(col, row)
    up_right_col= col
    up_right_row= row
    while up_right_col.between?(0,@maximum) && up_right_row.between?(0,@maximum) && @board[up_right_col][up_right_row] == players[current_player - 1].symbol do
      up_right_col += 1 
      up_right_row += 1
    end
    up_right_col -= 1
    up_right_row -= 1
    count = 0
    while up_right_col.between?(0,@maximum) && up_right_row.between?(0,@maximum) && @board[up_right_col][up_right_row] == players[current_player - 1].symbol do
      count += 1
      up_right_col -= 1
      up_right_row -= 1
    end
    count
  end

  def scan_up_left(col, row)
    up_left_col = col
    up_left_row = row
    while up_left_col.between?(0,@maximum) && up_left_row.between?(0,@maximum) && @board[up_left_col][up_left_row] == players[current_player - 1].symbol do
      up_left_col -= 1 
      up_left_row += 1
    end
    up_left_col += 1
    up_left_row -= 1
    count = 0
    while up_left_col.between?(0,@maximum) && up_left_row.between?(0,@maximum) && @board[up_left_col][up_left_row] == players[current_player - 1].symbol do
      count += 1
      up_left_col += 1
      up_left_row -= 1
    end
    count
  end
end
