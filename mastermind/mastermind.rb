class Game
	
	attr_reader :guesses

	def initialize
		setup
	end

	def setup
		@turn = 0
		@guesses = []
		@win = false

		code_set = false
		until code_set == true
			code_set = get_code
		end 

		until @turn == 12 || @win == true
			game_cycle
		end

	end

	def get_code
		puts "Enter code (separate with spaces): "
		code = gets.chomp
		set_code(code)
	end

	def set_code(code)
		@code = code.split(" ")
		puts "Setting code..."
		return true if @code.all? { |c| /[A-F]/.match(c) }
		return false
	end

	def get_guess
		puts "Enter guess (separate with spaces): "
		guess = gets.chomp
		set_guess(guess)
	end

	def set_guess(guess)
		@guess = guess.split(" ")
		puts "Here's the guess"
		return true if @guess.all? { |g| /[A-F]/.match(g) }
		return false
	end

	def check_guess(guess = @guess)
		e = check_exact(guess)
		a = check_any(guess) - e
		puts "Checking guess against code:"
		puts "Exactly correct: #{e}"
		puts "Correct but in the wrong spot: #{a}"
		if e == 4
			puts "Winner!"
			@win = true
		end
	end

	def check_exact(guess)
		e = 0
		@code.each_with_index do |c, i|
			e += 1 if guess[i] == c
		end
		return e
	end

	def check_any(guess)
		a = 0
		@code.each_with_index do |c, i|
			a += 1 if guess.any? { |g| g == c }
		end
		return a
	end

	def game_cycle
		@turn += 1
		guess_set = false
		until guess_set == true
			guess_set = get_guess
		end
		@guesses.push(@guess)
		check_guess
		display
	end

	def display
		@guesses.each do |g|
			puts "#{g.inspect} #{check_exact(g)} #{check_any(g) - check_exact(g)}"
		end
	end

end