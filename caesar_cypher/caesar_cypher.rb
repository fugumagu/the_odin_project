def cipher(phrase, n)
	coded_phrase = ''
	phrase.split("").each do |character|
		case character.ord
			when (65..90)
				if character.ord + n > 90
					coded_phrase += (character.ord + n - 26).chr
				else
					coded_phrase += (character.ord + n).chr
				end
			when (97..122)
				if character.ord + n > 122
					coded_phrase += (character.ord + n - 26).chr
				else
					coded_phrase += (character.ord + n).chr
				end
			else
				coded_phrase += character
		end
	end

	puts coded_phrase
end

cipher("What a string!", 5)
