# frozen_string_literal: true

require 'pry-byebug'

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
    player_turns if @mode == 2
    computer_turns if @mode == 1
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

  def player_turns
    puts display_guess_prompt
    code_input = gets.chomp
    if valid?(code_input)
      validity_array = guess_validity(code_input)
    else
      player_turns
    end
  end

  def guess_validity(code_input)
    input_array = code_input.split('').map(&:to_i)
    return_array = []
    return_array[0] = fully_correct(input_array)
    return_array[1] = partially_correct(input_array) - return_array[0]
    binding.pry
    # TODO: Fix single check logic
    # TODO: Add printing of correct guesses
    # TODO: Add victory condition
  end

  def fully_correct(input_array)
    return_value = 0
    input_array.each_with_index do |value, index|
      if @board.cells[index] == value
        return_value += 1
      end
    end
    return_value
  end

  def partially_correct(input_array)
    return_value = 0
    temp_cells = @board.cells.map(&:clone)
    temp_cells.each_with_index do |cell, index|
      input_array.each do |value|
        if value == cell
          temp_cells.delete_at(index)
          return_value += 1
          next
        end
      end
    end
    return_value
  end
end
