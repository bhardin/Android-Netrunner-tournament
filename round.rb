require './match'

class Round
	attr_reader :matches

	def initialize(max_size, matches=nil)
		if matches
			@matches = matches
		else 
			@matches = []
		end	
		@max_size = max_size
	end

	def add_match(match)
		raise "NotMatch" unless match.class.to_s == "Match"
		
		@matches << match
	end

	def full?
		@max_size == @matches.length
	end

end