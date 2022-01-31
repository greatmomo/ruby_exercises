# frozen_string_literal: true

require_relative 'node'

# try all 8 possible positions
# if not already visited and inside board
# add to queue with distance + 1 from parent state
# finally return distance when popped from queue

# Graph class for knight's travails
class Board
  attr_accessor :nodes, :board_size

  def initialize(size)
    @nodes = []
    @board_size = 0
    build_board(size)
  end

  def add_node(value)
    @nodes << Node.new(value)
  end

  def build_board(n)
    (0..n-1).each do |i|
      (0..n-1).each do |j|
        add_node([i,j])
      end
    end
    @board_size = n
  end

  def build_moveset
    # for each node, check if [+-1|2, +-1|2] is on the board
    # if it is, add an edge to that node
    #   how do I do this efficiently to actually link all the nodes properly and not just the values?
  end
end

board = Board.new(8)

board.nodes.each { |node| node.value[-1] == (board.board_size - 1) ? (print "#{node.value}\n") : (print "#{node.value} ") }

# knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

# > knight_moves([3,3],[4,3])
#   => You made it in 3 moves!  Here's your path:
#     [3,3]
#     [4,5]
#     [2,4]
#     [4,3]
