# frozen_string_literal: true

require_relative 'display'
require_relative 'board'

# Contains the logic to play the game
class Game
  include Display
  attr_reader :mode, :board

  def initialize
    @board = Board.new
    @mode = nil
  end

  def play
    game_set_up
    create_board if @mode == 1
    create_computer_board if @mode == 2
    board.show
    # player_turns
    # conclusion
  end

  private

  def game_set_up
    puts display_intro
    mode_select
  end

  def mode_select
    puts display_mode_select
    case gets.chomp
    when '1'
      @mode = 1
    when '2'
      @mode = 2
    else
      puts 'Invalid selection!'
      mode_select
    end
  end

  def create_board
    puts display_board_creation
    code_input = gets.chomp
    if valid?(code_input)
      code_array = code_input.split('')
      code_array.each do |value|
        @board.cells.push(value.to_i)
      end
    else
      create_board
    end
  end

  def valid?(input)
    unless input.length == 4
      puts 'Invalid input! Enter 4 numbers!'
      return false
    end
    input.split('').each do |value|
      unless value.to_i >= 1 && value.to_i <= 6
        puts 'Invalid input! Enter values between 1-6!'
        return false
      end
    end
    true
  end

  def create_computer_board
    4.times { @board.cells.push(rand(1..6)) }
  end
end
