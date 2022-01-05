# frozen_string_literal: true

# Mastermind board
class Board
  attr_reader :cells

  def initialize
    @cells = []
  end

  def update_board(number, index)
    @cells[index] = number
  end

  def match_board?(number, index)
    @cells[index] == number
  end

  # for debug only
  def show
    print @cells
    puts
  end
end
