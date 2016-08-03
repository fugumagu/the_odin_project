class Game

	class Player
		attr_reader :name

		def initialize(name)
			self.name = name 
		end

		def name=(name)
			@name = name.strip || 'Anonymous'
		end
	end

	attr_accessor :board, :turn, :players

	def initialize
		@board = []
		3.times{ @board.push([" ", " ", " "])}
		@turn = 1
		@players = []	
	end

	def launch!
		introduction
		get_players
		show_rules
		game_cycle
		end_game_wind_down
		conclusion
	end

	def introduction
		puts "\n<<<< Welcome to Tic-Tac-Toe >>>>!\n\n"
	end

	def conclusion
		puts "\n<<<< Thanks for playing! >>>>\n\n"
	end

	def get_players
		print "\nPlease enter a name for Player 1:> "
		p1 = gets.chomp

		print "\nPlease enter a name for Player 2:> "
		p2 = gets.chomp

		p1 = Player.new(p1)
		p2 = Player.new(p2)

		@players = p1, p2

		puts "\n<<<< Hello #{p1.name} and #{p2.name}! >>>>\n"
		puts "#{p1.name} will be X\'s and #{p2.name} will be O\'s\n\n"
	end

	def game_cycle
		response = nil
		end_of_game = nil

		until response == :quit || end_of_game
			action = get_action
			response = do_action(action)

			if response == :moved
				if game_over?
					end_of_game = true 
				else
					@turn += 1
				end
			end
		end		
	end

	def get_action

		action = nil
		# keep asking user for input until input is valid

		until allowable_actions.any?{ |a| a =~ action}
			puts "Unknown action. Type help for assistance.\n\n" if action
			print "#{current_player}'s turn :> "
			action = gets.chomp.to_s.downcase.strip
		end
		return action

	end

	def do_action(action)
		case action 
		when 'show'
			show(@board)
		when /\d/
			move(action)
		when 'help'
			help
		when 'quit'
			return :quit 
		end

	end

	def game_over?
		return true if victory?
		return true if board_full?
		return false
	end

	def move(cell)
		cell = cell.to_i
		row = (cell - 1) / 3
		column = (cell - 1) % 3
		if @board[row][column] == " "
			@board[row][column] = symbol
			show(@board)
			return :moved
		else
			puts "That square is already taken."
		end
	end

	def show(board)
		puts "\n"
		for i in (0..2)
			puts " #{board[i].join(' | ')} "
			if i < 2
				puts "-" * 11
			end
		end
		puts "\n"
	end

	def end_game_wind_down
		if victory?
			victory_celebration
		elsif board_full?
			draw
		else
			puts "Game ended early!"
		end
	end

	def victory?
		# check for horizontal win
		# check for vertical win
		# check for diagonal win
		h = []
		v = []
		d = []
		s = symbol

		for row in (0..2)
			h << @board[row].all?{ |l| l == s }
		end

		for col in (0..2)
			v << (@board[0][col] == s && @board[1][col] == s && @board[2][col] == s)
		end

		d << (@board[0][0] == s && @board[1][1] == s && @board[2][2] == s)
		d << (@board[0][2] == s && @board[1][1] == s && @board[2][0] == s)

		victory = h + v + d
		victory.any?{ |b| b == true }
	end

	def board_full?
		@turn >= 9 ? true : false
	end

	def help
		puts "\n<<<< Help >>>>"
		show_sample_board
		show_allowable_actions
		puts "help ... you're looking at it\n\n"
	end

	def symbol
		case
		when @turn % 2 != 0
			return "X"
		when @turn % 2 == 0
			return "O"
		end 
	end

	def current_player
		case symbol
		when "X"
			return @players[0].name
		when "O"
			return @players[1].name
		end
	end

	def victory_celebration
		case symbol
		when "X"
			winner = @players[0]
		when "O"
			winner = @players[1]
		end

		puts "\n\n#{symbol} wins! Congratulations #{winner.name}!"			
	end

	def draw
		puts "Game ends in a draw."
	end

	def show_allowable_actions
		puts "show ... shows the current game"
		puts "quit ... quits the current game"
		puts "1-9 .... enters move at location"
	end
	
	def allowable_actions
		return [/^show$/, /^quit$/, /^help$/, /^\d$/]
	end
	
	def show_sample_board
		sample_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]		
		puts "\nEnter a number 1-9 that corresponds to the square you want to place your mark."
		puts show(sample_board)
	end

	def show_rules
		puts "<<< How to Play >>>"
		show_sample_board
	end
end