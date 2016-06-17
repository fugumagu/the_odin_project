class Gallows

	def initialize
		#       _______
		#       |     |
		#       |     |
		#       |     O
		#       |    /|\ 
		#       |    / \   
		#       |
		#       |
		# =================
		#
		@top = %{       _______\n}
		@top = @top + %{       |     |\n}
		@top = @top + %{       |     |\n}
		@nothing = %{       |\n}

		@head = %{       |     O\n}

		@torso = %{       |     |\n}
		@arm = %{       |    /|\n}
		@arms = %{       |    /|\\\n}

		@leg = %{       |    /\n}
		@legs = %{       |    / \\\n}

		@bottom = %{       |\n}
		@bottom = @bottom + %{       |\n}
		@bottom = @bottom + %{ =================\n}
	end

	def update_gallows(wrong)
		case wrong
		when 0 then @body = [@nothing, @nothing, @nothing] #nothing
		when 1 then @body = [@head, @nothing, @nothing]
		when 2 then @body = [@head, @torso, @nothing]
		when 3 then @body = [@head, @arm, @nothing]
		when 4 then @body = [@head, @arms, @nothing]
		when 5 then @body = [@head, @arms, @leg]
		when 6 then @body = [@head, @arms, @legs]
		end

		@top + @body.join('') + @bottom
	end
end