arr = [9, 8, 7, 6, 5, 4, 3, 1, 2]

def bubble_sort(arr)
	len = arr.length
	occur = true
	
	until occur == false
		occur = false

		arr.each_with_index do |a, i|
			case
			when i != len - 1
				b = arr[i + 1]
				if 
					a <= b
				else
					arr[i] = b
					arr[i + 1] = a	
					occur = true
				end
			end
		end
	end
	puts arr.inspect
end



bubble_sort(arr)

def bubble_sort_by(arr)
	len = arr.length
	occur = true
	
	until occur == false
		occur = false

		arr.each_with_index do |a, i|
			case
			when i != len - 1
				b = arr[i + 1]
				if 
					yield(a, b) <= 0
				else
					arr[i] = b
					arr[i + 1] = a	
					occur = true
				end
			end
		end
	end
	puts arr.inspect
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end