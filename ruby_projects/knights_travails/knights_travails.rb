# frozen_string_literal: true

require_relative 'node'

# Graph class for knight's travails
class Board
  attr_accessor :nodes, :board_size
  DIRECTIONS = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]].freeze

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
    nodes.each do |key, node|
      DIRECTIONS.each do |dir|
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
    return puts 'Invalid entry' unless on_board?(start_node) && on_board?(target_node)
    
    paths = get_paths(nodes[start_node], nodes[target_node])
    shortest = paths.sort { |x,y| x.size <=> y.size }[0]
    puts "  => You made it in #{shortest.length - 1} moves! Here's your path:"
    shortest.each { |value| puts "\t#{value}" }
    # puts "\t#{target_node.value}"
  end

  def get_paths(start, target)
    solutions = []
    shortest = 50
    queue = [[start, [start.value]]]

    until queue.empty? do

      node, visited = queue.shift

      next if visited.length > shortest

      visited.push(node.value) unless visited.include? node.value

      if node == target
        solutions.push(visited)
        shortest = solutions.sort { |x,y| x.size <=> y.size }[0].length
        next
      end

      available = node.neighbour_values - visited
      available.each_with_index do |value, index|
        queue.push([nodes[value], visited.dup])
      end
    end
    solutions
  end
end

board = Board.new

board.build_moveset

puts "knight_moves([0,0],[6,7]):"
board.knight_moves([0,0],[6,7])
