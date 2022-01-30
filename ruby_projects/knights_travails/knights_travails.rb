# frozen_string_literal: true

# knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

# > knight_moves([3,3],[4,3])
#   => You made it in 3 moves!  Here's your path:
#     [3,3]
#     [4,5]
#     [2,4]
#     [4,3]

# board is [0,0] to [7,7]
# it shouldn't be possible to leave that board
# create a tree with every possible result? It's a graph, not a tree!
# don't allow repeated nodes

# try all 8 possible positions
# if not already visited and inside board
# add to queue with distance + 1 from parent state
# finally return distance when popped from queue

# graph is like a tree, but with a neighbors array
# so we can build a graph where each value [0,0] to [7,7] is a node
# and each of those has all its acceptable neighbors defined

# Graph class for knight's travails
class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_node(value)
    @nodes << Node.new(value)
  end
end