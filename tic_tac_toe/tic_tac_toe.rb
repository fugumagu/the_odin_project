class Game

	def initialize
		set_vars
		puts "Tic-Tac-Toe!"
		get_players
		show_board(@sample_board)
		show_board(@board)
		player_turn
	end

	def set_vars
		@sample_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		@board = []
		3.times{ @board.push([" ", " ", " "])}
		@turn = 0
		@s = nil
		return nil
	end

	private
	def get_players
		print "Please enter name for Player 1 (X's): "
		@P1 = gets.chomp

		print "Please enter name for Player 2 (O's): "
		@P2 = gets.chomp

		puts "\nHello #{@P1} and #{@P2}!"
		puts "\nTo play the game, you will enter the square number in which you'd like to place your mark."
		puts "Type \"show\" to view the current board. Type \"help\" to repeat the instructions."
	end

	def player_turn
		@turn += 1
		get_move
		winner if victory?
		draw if (board_full? && !victory)
		player_turn if (!(board_full?) && !(victory?))
	end

	def get_move
		case
		when @turn % 2 != 0
			@s = "X"
			@current_p = @P1
		when @turn % 2 == 0
			@s = "O"
			@current_p = @P2
		end

		print "#{@current_p}, please enter a square to place your #{@s}: "
		response = gets.chomp
		evaluate_response(response)
		return nil
	end

	def evaluate_response(response)
		case
		when response.downcase == "help" 
			help
		when response.downcase == "show"
			show_board(@board)
			get_move
		when /^[1-9]\s?$/
			response = response.to_i
			if response.between?(1, 9)
				valid_move(response)
			else
				puts "not a good integer"
			end
		else
			puts response.class
			puts "Please enter a number between 1 and 9."
			get_move
			return nil
		end
	end

	def valid_move(cell)
		row = (cell - 1) / 3
		column = (cell - 1) % 3
		if @board[row][column] == " "
			@board[row][column] = @s
			puts "Turn #{@turn}"
			show_board(@board)
		else
			puts "That square is already taken."
			get_move
		end
		return nil
	end

	def show_board(board)
		puts "\n"
		for i in (0..2)
			puts " #{board[i].join(' | ')} "
			if i < 2
				puts "-----------"
			end
		end
		puts "\n"
	end

	def victory?
		h = []
		v = []
		d = []

		for row in (0..2)
			h << @board[row].all?{ |l| l == @s }
		end

		for col in (0..2)
			v << (@board[0][col] == @s && @board[1][col] == @s && @board[2][col] == @s)
		end

		d << (@board[0][0] == @s && @board[1][1] == @s && @board[2][2] == @s)
		d << (@board[0][2] == @s && @board[1][1] == @s && @board[2][0] == @s)

		victory = h + v + d
		victory.any?{ |b| b == true }
	end

	def board_full?
		@turn >= 9 ? true : false
	end

	def help
		puts "\nEnter a number 1-9 that corresponds to the square you want to place your mark."
		puts show_board(@sample_board)
		get_move
	end

	def winner
		puts "#{@current_p} is the winner!"
	end

	def draw
		puts "Draw!"
	end
end

Game.new