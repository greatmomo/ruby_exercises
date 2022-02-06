# frozen_string_literal: true

# node class for Graph
class Node
  attr_accessor :value, :neighbours

  def initialize(value)
    @value = value
    @neighbours = []
  end

  def add_edge(neighbour)
    @neighbours << neighbour
  end

  def neighbour_values
    ret = @neighbours.map { |node| node.value }
    ret
  end
end
