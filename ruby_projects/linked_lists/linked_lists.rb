# frozen_string_literal: true

require_relative 'node'

class LinkedList
  attr_accessor :name
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def make_new(value)
    @head = Node.new(value)
    @tail = @head
  end

  def append(value)
    if @head == nil
      make_new(value)
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    if @head == nil
      make_new(value)
    else
      new_node = Node.new(value, @head)
      @head = new_node
    end
  end

  def size
    return 0 if @head.nil?
    scan = @head
    count = 1
    while !scan.next_node.nil? do 
      count += 1
      scan = scan.next_node
    end
    count
  end

  # head and tail should be automatic?

  def at(index)
  end

  def pop
  end

  def contains?(value)
  end

  def find(value)
  end

  def to_s
  end

  def insert_at(value, index)
  end

  def remove_at(index)
  end
end


my_list = LinkedList.new
puts "size = #{my_list.size}"
my_list.append(20)
my_list.append(40)
puts "size = #{my_list.size}"
my_list.prepend(11)
puts "head = #{my_list.head.value}, tail = #{my_list.tail.value}"
puts "size = #{my_list.size}"
