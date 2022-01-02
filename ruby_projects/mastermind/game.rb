# frozen_string_literal: true

require_relative 'display.rb'
require_relative 'board.rb'

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
    # board.show
    # player_turns
    # conclusion
  end

  private

  def game_set_up
    puts display_intro
    mode_select
    puts "Selected mode is: #{@mode}"
  end

  def mode_select
    puts display_mode_select
    mode_input = gets.chomp
    if mode_input == '1'
      @mode = 1
    elsif mode_input == '2'
      @mode = 2
    else
      puts "Invalid selection!"
      mode_select
    end
  end
end