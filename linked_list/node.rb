class Node
	attr_accessor :value, :next_node
	@@count = 0

	def initialize(value = nill)
		@value = value
		@next_node = nil
		@@count += 1
	end

	def Node.count
		@@count
	end
end
