require './player'
require './match'
require './round'

class Tournament
	attr_reader :players, :rounds, :status

	def initialize(players=nil)
		if players
			@players = players
		else 
			@players = [] 
		end
		@rounds = []
		@status = :not_started
	end

	def start
		if number_of_players.odd?
			@players << Player.new("BYE")
		end
		@status = :running
		@rounds << seed_round
	end

	def finalize_round
		@rounds << seed_round
	end

	def number_of_matches
		return @number_of_matches if @number_of_matches

		@number_of_matches = (number_of_players.to_f / 2).ceil
	end

	def number_of_rounds
		"undefined"
	end

	def number_of_players
		return @number_of_players if @number_of_players

		@number_of_players = @players.length
	end

	def round(number=nil)
		raise "NotStarted" if @status == :not_started
		@rounds[number] if number
		@rounds[0]
	end

	def create_matches
		raise "NotStarted" if @status == :not_started
		
		new_round = Round.new(number_of_matches)
		x=0

		number_of_matches.times do
			first_player = @players[x]
			second_player = @players[x+1]
			x += 2

			#if already_played?(first_player, second_player)
					
			#end
			#new_round.add_match(Match.new(first_player, second_player))
			new_round.add_match(Match.new(first_player, second_player))
		end

		return new_round		
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
	def seed_round
		sort_players
		return create_matches
	end

	def sort_players
		if @rounds.empty?
			@players.shuffle!
		else
			@players.sort! { |x,y| y.prestige_points <=> x.prestige_points }
		end
	end

end
