# frozen_string_literal: true

require_relative 'node'

# Represents a linked list data structure.
class LinkedList
  def append(value)
    insert_at(size, value)
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    else
      previous_head = @head
      @head = Node.new(value, previous_head)
    end
  end

  def insert_at(index, *values)
    raise IndexError if index.negative? || index > size

    prev_node, next_node = nodes_before_and_at_index(index)

    values.each do |value|
      new_node = Node.new(value, next_node)
      @head = new_node if prev_node.nil?
      prev_node.next_node = new_node unless prev_node.nil?
      prev_node = new_node
      next_node = new_node.next_node
    end
  end

  def remove_at(index)
    raise IndexError if index.negative? || index >= size

    prev_node, current_node = nodes_before_and_at_index(index)

    if prev_node.nil?
      @head = current_node.next_node
    else
      prev_node.next_node = current_node.next_node
    end
  end

  def size
    list_size = 0
    current_node = @head

    until current_node.nil?
      current_node = current_node.next_node
      list_size += 1
    end

    list_size
  end

  def head
    @head&.value
  end

  def tail
    return nil if @head.nil?

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?
    current_node.value
  end

  def at(index)
    return nil if @head.nil?

    current_node = @head
    index.times do
      return nil if current_node.next_node.nil?

      current_node = current_node.next_node
    end
    current_node.value
  end

  def pop
    return nil if @head.nil?

    head_value = @head.value
    @head = @head.next_node

    head_value
  end

  def contains?(value)
    !index(value).nil?
  end

  def index(value)
    current_node = @head
    current_index = 0
    until current_node.nil?
      return current_index if current_node.value == value

      current_node = current_node.next_node
      current_index += 1
    end

    nil
  end

  def to_s
    list_string = ''
    current_node = @head

    until current_node.nil?
      list_string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    "#{list_string}nil"
  end

  private

  def nodes_before_and_at_index(index)
    prev_node = nil
    next_node = @head

    index.times do
      prev_node = next_node
      next_node = prev_node.next_node
    end

    [prev_node, next_node]
  end
end
