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
    return Node.new(array[mid]) if mid.zero?

    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)..])

    root
  end

  def insert(value)
    node = @root
    while node
      return if node.value == value

      if node.value < value
        node.right ? node = node.right : (return node.right = Node.new(value))
      end
      if node.value > value
        node.left ? node = node.left : (return node.left = Node.new(value))
      end
    end
  end

  def delete(value)
    # delete
  end

  def find(value)
    # find
  end

  def level_order(&block)
    # yield something
  end

  def inorder(&block)
    # inorder
  end

  def preorder(&block)
    # preorder
  end

  def postorder(&block)
    # postorder
  end

  def height(node)
    # height
  end

  def depth(node)
    # depth
  end

  def balanced?
    # balanced
  end

  def rebalance
    # rebalance
  end

  def print_tree(root)
    return unless root

    print_tree(root.left)
    print "#{root.value} " unless root.value.nil?
    print_tree(root.right)
  end
end

input_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(input_array)
my_tree.print_tree(my_tree.root)
puts
my_tree.insert(11)
my_tree.print_tree(my_tree.root)
