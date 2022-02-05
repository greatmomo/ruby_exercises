# frozen_string_literal: true

require_relative 'node'

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

  def knight_moves(start_node, target_node)
    return 'Invalid entry' unless on_board?(start_node) || on_board?(target_node)
    
    paths = get_paths(nodes[start_node], nodes[target_node])
    puts "paths.size = #{paths.size}, paths = #{paths}"
    shortest = paths.sort { |x,y| x.size <=> y.size }
    puts "  => You made it in #{shortest.length} moves! Here's your path:"
    shortest[0].each { |value| puts "\t#{value}" }
    # puts "\t#{target_node.value}"
  end

  def get_paths(start, target)
    # rebuild this function as follows:
    # create a solutions[]
    # create a queue[]
    # add the first node to the queue, with an array of that node [node, [node.value]]
    # until queue.empty? do
    # - add valid neighbours to the queue as [node, visited + node.value]
    # - if the target is found, push the current visited array to solutions[]

    solutions = []
    queue = [[start, [start.value]]]

    until queue.empty? do
      # $stdout.flush
      # sleep(1)
      node, visited = queue.shift

      visited.push(node.value) unless visited.include? node.value

      if node == target
        solutions.push(visited)
        next
      end

      available = node.neighbour_values - visited
      puts "available: #{available}, neighbours: #{node.neighbour_values}, node.value: #{node.value}"
      available.each_with_index do |value, index|
        puts "available.each value: #{value}"
        queue.push([nodes[value], visited.dup])
        puts "queue: #{queue[index][0].value}, #{queue[index][1]}"
      end
    end
    solutions
  end
end

board = Board.new

board.build_moveset

puts "knight_moves([0,0],[3,3]):"
board.knight_moves([0,0],[3,3])

# knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
# knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
# knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

# > knight_moves([3,3],[4,3])
#   => You made it in 3 moves!  Here's your path:
#     [3,3]
#     [4,5]
#     [2,4]
#     [4,3]

# board.nodes.each { |key, node| key[-1] == (board.board_size - 1) ? (print "key: #{key}\n") : (print "key: #{key} ") }
# board.nodes[[7,7]].neighbors.each { |node| puts "#{node.value}" }
