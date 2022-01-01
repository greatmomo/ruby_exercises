# frozen_string_literal: true

require_relative 'display.rb'

# Contains the logic to play the game
class Game
  include Display
  # attr_reader :player, :board

  def initialize
    # @board = Board.new
    # @first_player = nil
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
  end
end