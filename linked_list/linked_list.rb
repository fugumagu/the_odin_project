require './node.rb'

class LinkedList
	attr_accessor :head

	def initialize(value)
		@head = Node.new(value)
	end

	def list
		node = @head
		puts node.value
		until node.next_node.nil?
			node = node.next_node
			puts node.value
		end
	end

	def append(value)
		node = Node.new(value)
		current = @head
		while !current.next_node.nil?
			current = current.next_node
		end
		current.next_node = node
		puts "Node appended"
	end

	def prepend(value)
		node = Node.new(value)
		node.next_node = @head
		@head = node
		puts "Node prepended"
	end

	def size
		c = 1
		current = @head
		until current.next_node.nil?
			current = current.next_node
			c += 1
		end
		c
	end

	def head
		@head.value
	end

	def tail
		current = @head
		until current.next_node.nil?
			current = current.next_node
		end
		current.value
	end

	def at(index)
		current = @head
		index.times { current = current.next_node }
		current.value
	end

	def pop
		current = @head
		until current.next_node.next_node.nil?
			current = current.next_node
		end
		next_last = current
		last = current.next_node
		last_val = last.value
		next_last.next_node = nil
		last = nil
		last_val
	end

	def contains?(value)
		current = @head
		until current.value == value || current.next_node.nil?
			current = current.next_node
		end
		
		if current.value == value
			return true
		else
			return false
		end
	end

	def find(data)
		c = 0
		current = @head
		until current.value == data || current.next_node.nil?
			current = current.next_node
			c += 1
		end

		if current.value == data
			return c
		else
			return false
		end
	end

	def to_s
		current = @head
		str = "#{current.value}"
		until current.next_node.nil?
			current = current.next_node
			str = "#{str} -> #{current.value}"
		end
		puts str
	end

	def insert_at(value, index)
		current = @head
		(index - 1).times{ current = current.next_node }
		before_i = current
		at_i = current.next_node
		node = Node.new(value)
		before_i.next_node = node
		node.next_node = at_i
	end

	def remove_at(index)
		current = @head
		(index - 1).times{ current = current.next_node }
		before_i = current
		after_i = current.next_node.next_node
		current.next_node = nil
		before_i.next_node = after_i
	end
end

list = LinkedList.new(50)
list.append(60)
list.append(70)
list.list
list.prepend(40)
list.prepend(30)
list.list
puts list.size
puts list.head
puts list.tail
puts list.at(3)
puts list.pop
list.list
puts list.contains?(50)
puts list.contains?(60)
puts list.contains?(70)
puts list.find(60)
puts list.find(85)
list.to_s
list.insert_at(100, 2)
list.to_s
list.remove_at(2)
list.to_s