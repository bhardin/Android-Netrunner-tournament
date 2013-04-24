require './player'

class Match
	attr_accessor :player1, :player2
	attr_accessor :score
	@score = []

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
	end

	def score(game_number, player1score, player2score)
		@score << {:game => game_number, @player1 => player1score, @player2 => player2score} 
	end
end