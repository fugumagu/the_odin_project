class Dict

	def initialize
	end

	def get_word
		dict = File.readlines("5desk.txt")

		word_ok = false

		until word_ok == true
			word = dict[rand(dict.length)].chomp
			word_ok = check_word(word)
		end
		word
	end

	private

	def check_word(word)
		if word.length >=5 && word.length <= 12 && /[a-z]/ =~ word[0]
			return true
		else
			return false
		end
	end
end

#dict = Dict.new
#puts dict.get_word