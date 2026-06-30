require_relative 'node'

class LinkedList
  def append(value)
    new_node = Node.new(value)
    
    if @head.nil?
      @head = new_node
    end

    unless @tail.nil?
      @tail.next_node = new_node
    end

    @tail = new_node
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
    raise IndexError if index < 0 || index > size

    prev_node = nil
    next_node = @head

    index.times do
      prev_node = next_node
      next_node = prev_node.next_node
    end

    values.each do |value|
      new_node = Node.new(value, next_node)
      @head = new_node if prev_node.nil?
      prev_node.next_node = new_node unless prev_node.nil?
      prev_node = new_node
      next_node = new_node.next_node
    end
  end

  def remove_at(index)
    raise IndexError if index < 0 || index >= size

    prev_node = nil
    current_node = @head
    
    index.times do
      prev_node = current_node
      current_node = current_node.next_node
    end

    if prev_node.nil?
      @head = current_node.next_node
    else
      prev_node.next_node = current_node.next_node
    end
  end

  def size
    return 0 if @head.nil?

    current_node = @head
    size = 1
    until current_node.next_node.nil? do
      current_node = current_node.next_node
      size += 1
    end
    size
  end

  def head
    @head&.value
  end

  def tail
    return nil if @head.nil?

    current_node = @head
    until current_node.next_node.nil? do
      current_node = current_node.next_node
    end
    current_node.value
  end

  def at(index)
    return nil if @head.nil?

    current_node = @head
    index.times do
      return nil if @head.next_node.nil?

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
    return nil if @head.nil?

    current_node = @head
    while current_node != nil do
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    
    false
  end

  def index(value)
    return nil if @head.nil?

    current_node = @head
    current_index = 0
    while current_node != nil do
      return current_index if current_node.value == value
      current_node = current_node.next_node
      current_index += 1
    end
    
    nil
  end

  def to_s
    list_string = ''

    current_node = @head
    until current_node.nil? do
      list_string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    list_string += 'nil'
  end
end