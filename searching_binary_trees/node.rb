class Node
	attr_accessor :value, :parent, :left_child, :right_child, :index, :coordinates

	def initialize(value)
		@value = value
		@parent = nil
		@left_child = nil
		@right_child = nil
		@index = nil
		@coordinates = nil
	end

end