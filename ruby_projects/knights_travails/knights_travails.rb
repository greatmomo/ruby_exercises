# frozen_string_literal: true

require_relative 'node'

# try all 8 possible positions
# if not already visited and inside board
# add to queue with distance + 1 from parent state
# finally return distance when popped from queue

# Graph class for knight's travails
class Board
  attr_accessor :nodes, :board_size

  def initialize(size = 8)
    @nodes = {}
    @board_size = 0
    build_board(size)
  end

  def add_node(key)
    @nodes[key] = Node.new(key)
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
    directions = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
    nodes.each do |key, node|
      directions.each do |dir|
        temp = sum_arrays(key, dir)
        node.add_edge(nodes[temp]) if on_board?(temp)
      end
    end
  end

  def sum_arrays(a1, a2)
    temp = a1.zip(a2)
    temp.map { |e1,e2| (e1.is_a? Array) ? sum_arrays(e1,e2) : e1+e2 }
  end

  def on_board?(arr)
    return true if (arr[0] >= 0 && arr[0] < board_size) && (arr[1] >= 0 && arr[1] < board_size)
    
    false
  end
end

board = Board.new

# board.nodes.each { |key, node| key[-1] == (board.board_size - 1) ? (print "key: #{key}\n") : (print "key: #{key} ") }

board.build_moveset

board.nodes[[7,7]].neighbors.each { |node| puts "#{node.value}" }

# knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

# > knight_moves([3,3],[4,3])
#   => You made it in 3 moves!  Here's your path:
#     [3,3]
#     [4,5]
#     [2,4]
#     [4,3]
