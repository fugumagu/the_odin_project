#The BinaryTree class builds a balanced tree with all the nodes as far left as possible.
#The tree is build from left to right
#For any balanced tree, the height will always be log2(number of nodes).floor
#Nodes are indexed starting from 0 to the total number of nodes
#The ordering of nodes goes from left to right starting from the top

#It is easy to find the index of a left child or a right child given the parent's index
#Index of left child = 2 * (Index of Parent) + 1
#Index of right child = 2 * (Index of Parent) + 2
#A node will never have a left/right child if the would-be child index is greater than the number of nodes
#This makes it easy to create a node, assign it an index based on its parent, and then create more children with indices

#The process to build the tree is as follows:
	#Create the root node

	#1
	#If there is not a left child and there should be (the would-be left child index is less than the total nodes)
	#Then create the left child, set the left child pointer and parent point, then move to the left child
	#Go back to 1

	#2
	#If there is a left child, then see if there is a right child
	#If there is not but there should be (the would-be right child index is less than the total nodes)
	#Then create the right child, set the pointers, then move to the right child
	#Go back to 2

	#3
	#If there is a left child and a right child, or they don't exist but shouldn't
	#Then move back to the parent node
	#Go back to 1

	#Once all the nodes are created, the builder moves back to the root node, sees that it is at the top of the tree
	#and then sees that there are both left and right children. The builder stops here and the tree is built

	#The coordinates for each node indicate the number of 'Right' and 'Left' turns at each node starting from the Head ('H')

require_relative 'node.rb'

class BinaryTree
	attr_accessor :root, :arr, :node_count, :height, :bottom_row, :bottom_row_capacity

	def initialize(arr)
		puts "Building binary tree..."
		@arr = arr
		@node_count = arr.length
		@height = Math::log2(@node_count).floor
		@bottom_row = @node_count - (2**(@height) - 1)
		@bottom_row_capacity = 2**(@height)
		build_tree
	end

	def build_tree
		puts "Examining array: #{arr.inspect}"
		puts "Importing #{@node_count} nodes..."
		puts "Binary table will have a height of #{@height}"
		puts "Bottom row will have #{@bottom_row} node(s)"
		puts "Bottom row capacity is #{@bottom_row_capacity}"

		@root = Node.new(arr[0])
		@root.index = 0
		@root.coordinates = "H"
		current = @root		

		#start cycle
		done = false
		until done
			case !current.left_child.nil? #Look if the left child exists
			when true #Left child exists
				case !current.right_child.nil? #Look if the right child exists
				when true #Right child does exist => Move current to parent node
					#Don't move to the parent if the current node is at the root (current.parent is nil)
					if !current.parent.nil?
						current = current.parent
					else
						done = true
					end
				when false #Right child does not exist
					case right_child_should_exist?(current) #Look if the right child SHOULD exist
					when true #Right child should exist but does not => create node at right child
						right_child = create_right_child(current) #Create a right child from the current node
						current.right_child = right_child #Set the right child pointer for the current node
						current = right_child #Move to the newly created node
					when false #Right child should not exist and does not exist => Move current to parent
						#Don't move to the parent if the current node is at the root (current.parent is nil)						
						if !current.parent.nil?
							current = current.parent
						else
							done = true
						end
					end
				end
			when false #Left child does not exist
				case left_child_should_exist?(current)
				when true #Left child should exist but does not exist => Create node at left child
					left_child = create_left_child(current) #Create a left child from the current node
					current.left_child = left_child #Set the left child pointer for the current node
					current = left_child #Move to the newly created node
				when false #Left child should not exist AND does not exist => Node is a leaf => Move current to parent
					#Don't move to the parent if the current node is at the root (current.parent is nil)					
					if !current.parent.nil?
						current = current.parent						
					else
						done = true
					end
				end
			end
		end
		puts "Table created"
	end

	def left_child_should_exist?(node)
		#A left child should exist if the left child index is less than the total node count
		#Calculate the left child index with (2 * current node index) + 1
		if (2 * node.index) + 1 >= @node_count
			return false
		else
			return true
		end
	end

	def right_child_should_exist?(node)
		#A right child should exist if the right child index is less than the total node count
		#Calculate the right child index with (2 * current node index) + 2
		if (2 * node.index) + 2 >= @node_count
			return false
		else
			return true
		end
	end

	def create_left_child(parent)
		child_index = parent.index * 2 + 1 #Calculate the index of the left child
		child_value = @arr[child_index] #Get the value from the array at the index of left child
		child = Node.new(child_value) #Create the left child
		child.parent = parent #Set the parent pointer of the child to the current node
		child.coordinates = parent.coordinates + "L" #Concatenate 'L' to the coordinates of the child
		child.index = child_index #Set the child's index
		return child
	end

	def create_right_child(parent)
		child_index = parent.index * 2 + 2 #Calculate the index of the right child
		child_value = @arr[child_index] #Get the value from the array at the index of right child
		child = Node.new(child_value) #Create the right child
		child.parent = parent #Set the parent pointer of the child to the current node
		child.coordinates = parent.coordinates + "R" #Concatenate 'R' to the coordinates of the child
		child.index = child_index #Set the child's index
		return child
	end

	def breadth_first_search(value)
		queue = []
		read = []
		current = @root
		found = nil
		done = false

		until done
			#Look for fresh left node, read node, mark as read, add to queue
			if !current.left_child.nil? && !read.include?(current.left_child)
				if current.left_child.value == value
					found = current.left_child
					done = true
				else
					read << current.left_child
					queue << current.left_child
				end
			end

			#Look for fresh right node, read node, mark as read, add to queue		
			if !current.right_child.nil? && !read.include?(current.right_child) && found.nil?
				if current.right_child.value == value
					found =  current.right_child
					done = true
				else
					read << current.right_child
					queue << current.right_child
				end
			end		
			
			#No more nodes? Move to node next in queue and remove from queue
			if queue.length != 0
				current = queue.shift
			else
				done = true
			end
		end

		if !found.nil?
			puts "Found #{value} at node #{found.index} (#{found.coordinates})"
		else
			puts "#{value} not found"
		end

	end

	def depth_first_search(value)
		stack = []
		read = []
		current = @root
		found = nil
		done = false
		
		#Add root to stack
		stack << current

		until done
		#Look for a fresh left node, read node, mark as read, add to stack, move there			
			if !current.left_child.nil? && !read.include?(current.left_child)
				if current.left_child.value == value
					found = current.left_child
					done = true
				else
					stack << current.left_child
					read << current.left_child
					current = current.left_child
				end
			#Otherwise, look for a fresh right node, read node, mark as read, add to stack, move there			
			elsif !current.right_child.nil? && !read.include?(current.right_child) && found.nil?
				if current.right_child.value == value
					found = current.right_child
					done = true
				else
					stack << current.right_child
					read << current.right_child
					current = current.right_child
				end
			#No more nodes? Go to top of stack and remove from stack			
			else
				if stack.length > 0
					current = stack.pop
				else
					done = true
				end
			end
		end

		if found.nil?
			puts "#{value} not found"
		else
			puts "Found #{value} at node #{found.index} (#{found.coordinates})"
		end

	end

	def dfs_rec(value)
	end
end
