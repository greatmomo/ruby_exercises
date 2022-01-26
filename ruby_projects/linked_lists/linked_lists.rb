# frozen_string_literal: true

require_relative 'node'

# Linked List implementation
class LinkedList
  attr_accessor :name
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    if @head
      tail.next_node = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  def tail
    node = @head

    return node unless node.next_node

    return node unless node.next_node while (node = node.next_node)
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    else
      node = @head
      @head = Node.new(value)
      @head.next_node = node
    end
  end

  def size
    return 0 if @head.nil?

    node = @head
    count = 1
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
  end

  def at(index)
    return nil if size < index

    node = @head
    index.times { node = node.next_node }
    return node if node

    nil
  end

  def pop
    node = @head
    prev = node
    value = node.value
    while node.next_node
      value = node.next_node.value
      prev = node
      node = node.next_node
    end
    prev.next_node = nil
    @head = nil if node == @head
    value
  end

  def contains?(value)
    node = @head
    return true if node.value == value

    while (node = node.next_node)
      return true if node.value == value
    end
    false
  end

  def find(value)
    node = @head

    count = 0
    return node if node.value == value
    return false unless node.next_node

    while (node = node.next_node)
      count += 1
      return count if node.value == value
    end
  end

  def to_s
    node = @head
    output = ''
    output = "( #{node.value} ) -> " if node

    while (node = node.next_node)
      output += "( #{node.value} ) -> " if node
    end
    output += 'nil' unless node
    output
  end

  def insert_at(value, index)
    node = @head

    index.times { node = node.next_node }

    return unless node

    old_next = node.next_node
    node.next_node = Node.new(value)
    node.next_node.next_node = old_next
  end

  def remove_at(index)
    node = @head
    @head = node.next_node if index.zero?

    (index - 1).times do
      node = node.next_node
    end

    return unless node.next_node

    node.next_node = node.next_node.next_node
  end
end

my_list = LinkedList.new
my_list.append(20)
puts my_list.to_s
my_list.append(40)
puts my_list.to_s
my_list.prepend(11)
puts "pop = #{my_list.pop}"
puts my_list.to_s

my_list.remove_at(0)
puts my_list.to_s
puts "contains?(20) = #{my_list.contains?(20)}, " \
     "contains?(33) = #{my_list.contains?(33)}"

# puts "head = #{my_list.head.value}, tail = #{my_list.tail.value}"
