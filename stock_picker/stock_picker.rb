def picker(arr)
	best_buy = 0
	best_sell = 0
	best_profit = 0

	arr.each_with_index do |val, index|
		for i in (index..(arr.length-1))
			if arr[i] - val > best_profit
				best_buy = index
				best_sell = i
				best_profit = arr[i] - val
				print "index: #{index}; val: #{val}; best buy: #{best_buy}; best sell: #{best_sell}; profit: #{best_profit} \n"
			end
		end
	end
end

picker([20,3,6,9,15,8,6,19,2])