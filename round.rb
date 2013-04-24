require './match'

class Round
	@matches = []

	def initialize(matches=nil)
		if matches
			@matches = matches
		end
	end

end