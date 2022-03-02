# frozen_string_literal: true

class Player
  def initialize(symbol)
    @symbol = symbol
  end

  attr_reader :symbol
end
