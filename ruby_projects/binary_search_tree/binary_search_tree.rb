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

  # expect 8 4 67 3 5 23 324 1 7 9 6345
  def level_order(node, &block)
    return nil unless node

    queue = []
    queue.push(node)
    arr = []
    while !queue.empty?
      node = queue.shift
      arr.push(node.value)
      yield(node) if block_given?
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
    arr.flatten
  end

  # expect 1 3 4 5 7 8 9 23 67 324 6345
  def inorder(node, &block)
    arr = []
    arr.push(inorder(node.left, &block)) if node.left
    arr.push(node.value)
    yield(node) if block_given?
    arr.push(inorder(node.right, &block)) if node.right

    arr.flatten
  end

  # expect 8 4 3 1 5 7 67 23 9 324 6345
  def preorder(node, &block)
    arr = []
    arr.push(node.value)
    yield(node) if block_given?
    arr.push(preorder(node.left, &block)) if node.left
    arr.push(preorder(node.right, &block)) if node.right

    arr.flatten
  end

  # expect 1 3 7 5 4 9 23 6345 324 67 8
  def postorder(node, &block)
    arr = []
    arr.push(postorder(node.left, &block)) if node.left
    arr.push(postorder(node.right, &block)) if node.right
    arr.push(node.value)
    yield(node) if block_given?

    arr.flatten
  end

  def height(node)
    return 0 unless node

    lheight = height(node.left)
    rheight = height(node.right)

    lheight > rheight ? (return lheight + 1) : (return rheight + 1)
  end

  def depth(node)
    # depth
  end

  def balanced?
    # balanced
  end

  def rebalance
    arr = self.inorder(self.root)

    Tree.new(arr)
  end
end

# The ultimate test
my_tree = Tree.new((Array.new(15) { rand(1..100) }))
puts "balanced? = #{my_tree.balanced?}"
print "level_order = #{my_tree.level_order(my_tree.root)}\n"
print "preorder = #{my_tree.preorder(my_tree.root)}\n"
print "postorder = #{my_tree.postorder(my_tree.root)}\n"
print "inorder = #{my_tree.inorder(my_tree.root)}\n"
my_tree.insert(169)
my_tree.insert(845)
my_tree.insert(145)
my_tree.insert(542)
my_tree.insert(923)
puts "inserted 169, 845, 145, 542, 923"
puts "balanced? = #{my_tree.balanced?}"
puts "rebalancing"
my_tree = my_tree.rebalance
puts "balanced? = #{my_tree.balanced?}"
print "level_order = #{my_tree.level_order(my_tree.root)}\n"
print "preorder = #{my_tree.preorder(my_tree.root)}\n"
print "postorder = #{my_tree.postorder(my_tree.root)}\n"
print "inorder = #{my_tree.inorder(my_tree.root)}\n"
