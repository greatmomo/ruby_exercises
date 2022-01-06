# frozen_string_literal: true

# Mastermind board
class Computer
  attr_reader :known_values

  def initialize
    @known_values = []
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
end
