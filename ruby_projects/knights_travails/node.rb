# frozen_string_literal: true

# node class for Graph
class Node
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = []
  end

  def add_edge(neighbor)
    @neighbors << neighbor
  end
end