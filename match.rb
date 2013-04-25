require './player'

class Match
	attr_accessor :player_one, :player_two
	attr_reader :status, :player_one_prestige, :player_two_prestige

	def initialize(player_one, player_two)
		@player_one = player_one
		@player_one_prestige = 0
		@player_two = player_two
		@player_two_prestige = 0
		@score = []
		@status = :game_one
	end

	def score_game(player1score, player2score)
		raise "InvalidScore" unless score_valid?(player1score) && score_valid?(player2score)
		raise "InvalidScore" if both_players_higher_than_seven?(player1score, player2score)
		raise "AlreadyFinished" if self.status == :finished

		@score << {:game => @status, :player_one => player1score, :player_two => player2score} 
		advance_status
		return true
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

	def advance_status
		if @status == :game_one
			@status = :game_two
		elsif :game_two
			@status = :finished
			calculate_prestige
		end
	end

	def calculate_prestige
		player_one_total = 0
		player_two_total = 0

		@score.each do | game |
			player_one_score = game[:player_one]
			player_two_score = game[:player_two]

			if player_one_score > player_two_score
				@player_one_prestige += 2
			elsif player_two_score > player_one_score
				@player_two_prestige += 2
			else
				@player_one_prestige += 1
				@player_two_prestige += 1
			end

			player_one_total += player_one_score
			player_two_total += player_two_score
		end

		if player_one_total > player_two_total
				@player_one_prestige += 2
		elsif player_two_total > player_one_total
			@player_two_prestige += 2
		else
			@player_one_prestige += 1
			@player_two_prestige += 1
		end
	end
end