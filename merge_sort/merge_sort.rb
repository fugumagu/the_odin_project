def merge_sort(arr)
	case arr.length
	when 1
		return arr

	#If arr.length > 1 then split arr into two halves: a_arr and b_arr
	else 
		a_arr = merge_sort(arr.slice(0, arr.length / 2))
		b_arr = merge_sort(arr.slice(arr.length / 2, arr.length - 1))

		c_arr = []

		#then, sort
		while a_arr.length > 0 && b_arr.length > 0
			if a_arr[0] < b_arr[0]
				c_arr << a_arr.shift
			else
				c_arr << b_arr.shift
			end
			c_arr += a_arr if b_arr.length == 0
			c_arr += b_arr if a_arr.length == 0
		end
		return c_arr
	end
end

puts merge_sort([2,1,5,6,8,2,3,6,7,12,16,1,7,8,4,9,17,13,18,10]).inspect