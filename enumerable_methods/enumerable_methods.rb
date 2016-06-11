module Enumerable
	
	def my_each
		return self unless block_given?
		for i in (0...self.length)
			yield(self[i])
		end
	end

	def my_each_with_index
		return self unless block_given?
		for i in (0...self.length)
			yield(self[i], i)
		end
	end

	def my_select
		arr = []
		for i in (0...self.length)
			arr.push(self[i]) if yield(self[i])
		end
		arr
	end

	def my_all?
		for i in (0...self.length)
			return false if !(yield(self[i]))
		end
		true
	end

	def my_any?
		for i in (0...self.length)
			return true if yield(self[i])
		end
		false
	end

	def my_none?
		for i in (0...self.length)
			return false if yield(self[i])
		end
		true
	end

	def my_count
		c = 0
		
		case block_given?
		when true
			for i in (0...self.length)
				c += 1 if yield(self[i])
			end
		when false
			c = self.length
		end
		c
	end

	def my_map
		a = []
		for i in (0...self.length)
			a << yield(self[i])
		end
		a
	end

	def my_inject(s)
		z = s
		self.my_each { |e| z = yield(z, e) }
		z
	end

	def multiply_els
		self.my_inject(1){ |res, ele| res * ele }
	end
end

my_proc = Proc.new { |x| x**2 }

#[1, 2, 3, 4, 5].my_each{ |a| puts "Hi" }
#[1, 2, 3, 4, 5].my_each_with_index{ |a, i| puts "Hi #{a}#{i}" }
#puts [1, 2, 3, 4, 5].my_select{ |n| n > 2 }
#puts [1, 2, 3, 4, 5].my_all?{ |n| n > 1 }
#puts [1, 2, 3, 4, 5].my_any?{ |n| n > 5 }
#puts [1, 2, 3, 4, 5].my_none?{ |n| n > 4 }
#puts [1, 2, 3, 4, 5].my_count{ |n| n > 2 }
#puts [1, 2, 3, 4, 5].my_map { |n| n**2 }
#puts [1, 2, 3, 4, 5].my_inject(1) { |res, ele| res * ele }
#puts [1, 2, 3, 4, 5].multiply_els
#puts [1, 2, 3, 4, 5].my_map(&my_proc)
#puts [1, 2, 3, 4, 5].my_map(&:to_s)