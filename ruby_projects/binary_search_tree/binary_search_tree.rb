# frozen_string_literal: true

require_relative 'node'

# Tree class for binary search tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    mid = array.length / 2
    return Node.new(array[mid]) if mid == 0
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid+1)..-1])

    root
  end

  def print_tree(root)
    return unless root
    puts "#{root.value}" unless root.value.nil?
    print_tree(root.left)
    print_tree(root.right)
  end
end

# get middle of array and make it root
# recursively repeat for left half and right half
  # get middle of left half and make it left child of root
  # get middle of right half and make it right child of root

input_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(input_array)
my_tree.print_tree(my_tree.root)
