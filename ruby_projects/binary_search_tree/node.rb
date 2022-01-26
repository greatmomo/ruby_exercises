# frozen_string_literal: true

# Node class for Binary Search Tree
class Node
  include Comparable
  attr_accessor :value, :left, :right

  def <=>(other)
    value <=> other.value
  end
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end
