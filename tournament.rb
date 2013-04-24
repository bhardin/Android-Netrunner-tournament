require './player'
require './match'
require './round'

class Tournament
	attr_reader :players, :rounds

	def initialize(players=nil)
		if players
			@players = players
		else 
			@players = [] 
		end
		@rounds = []
	end

	def start
		if number_of_players.odd?
			@players << Player.new("BYE")
		end
	end

	def number_of_matches
		return @number_of_matches if @number_of_matches

		@number_of_matches = (number_of_players.to_f / 2).ceil
	end

	def number_of_players
		return @number_of_players if @number_of_players

		@number_of_players = @players.length
	end

	def round(number=nil)
		raise "NoPlayers" if @players.empty?
		raise "NoRounds" if @rounds.empty?
		@rounds[number] if number
		@rounds.last
	end

	def create_matches
		randomize_players
		new_round = []
		i = 0

		number_of_matches.times do
			first_player = @players[i]
			second_player = @players[i+1]

			if already_played?(first_player, second_player)
				
			end
			new_round << Match.new(first_player, second_player)
			i += 2
		end

		@rounds << new_round
	end

	def already_played?(player1, player2)
		@rounds.each do | round |
			round.each do | match |
				return true if match.player1 == player1 and match.player2 == player2
				return true if match.player1 == player2 and match.player2 == player1
			end
		end
		return false
	end

	private
	def randomize_players

	end



end
