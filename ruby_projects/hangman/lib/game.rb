# frozen_string_literal: true

# Game class stores current game state and checks for victory
class Game
  attr_reader :word_to_guess
  attr_accessor :guesses, :turn

  def initialize
    @dictionary = Dictionary.new
    @word_to_guess = @dictionary.random_word
    @guesses = []
    @turn = 1
  end

  def print_state
    state = ''
    chars = @word_to_guess.split('')
    chars.each do |char|
      state += if @guesses.include?(char)
                 "#{char} "
               else
                 '_ '
               end
    end
    state
  end

  def all_guessed?
    return false if print_state.include?('_')

    true
  end
end
