# frozen_string_literal: true

require 'pry-byebug'

require_relative 'display'
require_relative 'board'
require_relative 'computer'

# Contains the logic to play the game
class Game
  include Display
  attr_reader :mode, :board

  def initialize
    @board = Board.new
    @computer = Computer.new
    @mode = nil
    @turn_counter = 0
    @victory_state = false
  end

  def play
    game_set_up
    create_board if @mode == 1
    create_computer_board if @mode == 2
    player_turns if @mode == 2
    computer_turns if @mode == 1
    conclusion
  end

  private

  def game_set_up
    @turn_counter = 1
    @victory_state = false
    puts display_intro
    mode_select
    puts display_validity_description
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
    puts "Turn #{@turn_counter}: " + display_guess_prompt
    code_input = gets.chomp
    if valid?(code_input)
      validity_array = guess_validity(code_input.split('').map(&:to_i))
      print ' '.on_light_blue + ('♥ ' * validity_array[0]).on_light_blue
      print ('• ' * validity_array[1]).on_light_blue
      print '   '.on_light_blue if validity_array[0] == 0 && validity_array[1] == 0
      puts
      @turn_counter += 1
      player_turns unless @turn_counter > 12 || validity_array[0] == 4
    else
      player_turns
    end
  end

  def guess_validity(input_array)
    temp_input = input_array.clone
    temp_cells = @board.cells.clone
    return_array = []
    return_array[0] = fully_correct(temp_input, temp_cells)
    return_array[1] = partially_correct(temp_input, temp_cells)
    @victory_state = true if return_array[0] == 4
    return_array
  end

  def fully_correct(guess, master)
    exact = 0
    master.each_with_index do |value, index|
      next unless value == guess[index]

      exact += 1
      master[index] = '*'
      guess[index] = '*'
    end
    exact
  end

  def partially_correct(guess, master)
    partial = 0
    guess.each_index do |index|
      next unless guess[index] != '*' && master.include?(guess[index])

      partial += 1
      remove = master.find_index(guess[index])
      master[remove] = '?'
      guess[index] = '?'
    end
    partial
  end

  def hash_generator(input_array)
    result = Hash.new(0)
    input_array.each { |value| result[value] += 1 }
    return result
  end

  def conclusion
    if @victory_state
      puts "Correct code!"
      puts display_winner(@mode == 1 ? 'computer' : 'player')
    else
      puts "Out of turns!"
      puts display_winner(@mode == 2 ? 'computer' : 'player')
    end
  end

  def computer_turns
    computer_input = computer_codegen
    puts "Turn #{@turn_counter}: #{computer_input}"
    validity_array = guess_validity(computer_input)
    print ' '.on_light_blue + ('♥ ' * validity_array[0]).on_light_blue
    print ('• ' * validity_array[1]).on_light_blue
    print '   '.on_light_blue if validity_array[0] == 0 && validity_array[1] == 0
    puts
    @turn_counter += 1
    computer_turns unless @turn_counter > 12  || validity_array[0] == 4
  end

  def computer_codegen
    case @turn_counter
    when 1
      return [1,1,1,1]
    else
      return Array.new(4) { rand(1..6) }
      # computer checks working, now need to update logic and it's done!
    end
  end
end
