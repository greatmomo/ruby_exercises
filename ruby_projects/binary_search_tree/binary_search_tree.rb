# frozen_string_literal: true

require_relative 'node'

# Tree class for binary search tree
class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return nil if array.empty?

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

  def min_value_node(node)
    node = node.left while node&.left

    node
  end

  def delete(root, value)
    return root if root.nil?

    case
    when value < root.value
      root.left = delete(root.left, value)
    when value > root.value
      root.right = delete(root.right, value)
    else
      if root.left.nil? && root.right.nil?
        return nil
      elsif root.left.nil?
        root = root.right
        return root
      elsif root.right.nil?
        root = root.left
        return root
      end

      temp = min_value_node(root.right)
      root.value = temp.value
      root.right = delete(root.right, temp.value)
    end
    root
  end

  def find(value, node = root)
    return node if node.nil? || node.value == value

    value < node.value ? find(value, node.left) : find(value, node.right)
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
    print "#{root.value} "
    print_tree(root.right)
  end
end

input_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_tree = Tree.new(input_array)
my_tree.print_tree(my_tree.root)
puts
my_tree.delete(my_tree.root, 3)
my_tree.print_tree(my_tree.root)
puts
puts "find = #{my_tree.find(7)}"
