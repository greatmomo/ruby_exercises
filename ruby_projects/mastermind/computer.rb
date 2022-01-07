# frozen_string_literal: true

# Mastermind board
class Computer
  attr_reader :known_values, :guessed_permutations, :banned_values
  attr_accessor :previous_guess

  def initialize
    @known_values = []
    @guessed_permutations = []
    @banned_values = Array.new(4) { [] }
    @previous_guess = []
  end

  def update_known(number, count)
    count.times do
      @known_values.push(number)
    end
  end

  # for debug only
  def show_known
    print @known_values
    puts
  end

  def known_length
    @known_values.length
  end

  def add_guessed(input_array)
    @guessed_permutations.push(input_array)
  end

  def ban_current(input_array)
    input_array.each_with_index do |value, index|
      @banned_values[index].push(value) unless @banned_values[index].include?(value)
    end
  end
end
