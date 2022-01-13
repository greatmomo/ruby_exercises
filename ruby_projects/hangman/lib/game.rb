# frozen_string_literal: true

# Game class stores current game state and checks for victory
class Game
  attr_reader :word_to_guess
  attr_accessor :guesses, :turn

  def initialize
    @dictionary = Dictionary.new
    @word_to_guess = @dictionary.random_word
    @guesses = []
    @turn = 0
  end

  def print_state
    state = ''
    chars = @word_to_guess.split('')
    chars.each do |char|
      if @guesses.include?(char)
        state += char + ' '
      else
        state += '_' + ' '
      end
    end
    state
  end

  def all_guessed?
    return false if print_state.include?('_')
    return true
  end
end
