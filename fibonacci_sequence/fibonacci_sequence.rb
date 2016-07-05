def fibs(n)
	arr = [1, 1]
	(n - 2).times{ arr << arr[-1] + arr[-2]}
	arr
end


def fibs_rec(n)
	return [1, 1] if n == 2
	fibs_rec(n - 1) << (fibs_rec(n - 1)[-1] + fibs_rec(n - 1)[-2])
end

puts fibs(10).inspect
puts fibs_rec(10).inspect