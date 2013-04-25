require './player'

class Match
	attr_accessor :player_one, :player_two

	def initialize(player_one, player_two)
		@player_one = player_one
		@player_two = player_two
		@score = []
	end

	def score_game(game_number, player1score, player2score)
		raise "InvalidScore" unless score_valid?(player1score) && score_valid?(player2score)
		raise "InvalidScore" if both_players_higher_than_seven?(player1score, player2score)

		@score << {:game => game_number, @player_one => player1score, @player_two => player2score} 
	end

	def score
		return 0 if @score.empty?
	end

	private
	def score_valid?(score)
		return (score >= 0 && score <= 10)
	end

	def both_players_higher_than_seven?(score1, score2)
		return score2 >= 7 if score1 >= 7
		return false
	end
end