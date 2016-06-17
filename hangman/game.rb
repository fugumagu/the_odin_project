require_relative 'dict.rb'
require_relative 'gallows.rb'
require 'yaml'

class Game

	def initialize
		print "load game or new game? "
		start = gets.chomp
		case start
		when 'load'
			load_game
		when 'new'
			new_game
		end
	end

	def new_game
		@wrong = []
		@correct = []
		get_gallows
		get_word
		game_cycle
	end

	def get_word
		d = Dict.new
		@word = d.get_word
	end

	def show_word
		word_hidden = @word.split('')
		word_hidden.map! do |l|
			case @correct.include?(l)
			when true
				l
			when false
				"_"
			end
		end
		#puts @word
		return word_hidden.join(' ')
	end

	def guess
		print "Pick a letter: "
		gets.chomp.downcase
	end

	def get_gallows
		@gallows = Gallows.new
	end

	def show_gallows(num_wrong)
		puts @gallows.update_gallows(num_wrong)
	end

	def eval_guess(guess)
		if guess.downcase == 'save'
				save_game
				exit
		elsif !(@wrong.include?(guess)) && !(@correct.include?(guess))
			if guess =~ /^[a-z]$/
				eval_correct_or_wrong(guess)
				return false
			else
				return "Enter a single letter only."
			end
		elsif (@wrong.include?(guess) || @correct.include?(guess))
			return "You've already guessed that letter. Try again."
		end
	end

	def eval_correct_or_wrong(guess)
		if @word.include?(guess)
			@correct.push(guess)
		else
			@wrong.push(guess)
		end
		#show_gallows(@wrong.length)
		#show_word
	end

	def show_status
		system("clear")
		show_gallows(@wrong.length)
		puts show_word
		puts "Incorrect guesses: #{@wrong.join(' ')}"
	end

	def game_cycle
		win = false
		warning = nil

		while win == false && @wrong.length < 6
			show_status
			puts warning if warning
			puts @word
			warning = eval_guess(guess)
			win = true unless show_word.include?("_")
		end

		show_status

		if win == true
			puts "You win!"
		else
			puts "You lose! The word was #{@word}!"
		end
	end

	def save_game
		save = YAML::dump([@wrong, @correct, @word])
		File.open("saves/saved.txt", "w") << save
	end

	def load_game
		load = File.open("saves/saved.txt", 'r')
		load = YAML::load(load)
		puts load.inspect
		@wrong = load[0]
		@correct = load[1]
		@word = load[2]
		get_gallows
		game_cycle
	end

end

game = Game.new
#game.save_game