def substrings(phrase, dictionary)
	word_tally = Hash.new
	low_phrase = phrase.downcase
	
	dictionary.each do |w|
		count = low_phrase.scan(w).length
		word_tally[w] = count if count > 0
	end

	puts word_tally

end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)