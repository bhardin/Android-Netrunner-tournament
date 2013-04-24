require './tournament'

describe Tournament do
	# let :player1 Player.new("asdf adfasd")

	describe ".number_of_matches" do
		context "when an even number of people are in the tournament" do
			it "returns the right number of rounds" do
				@player1 = Player.new("a")
				@player2 = Player.new("b")
				@players = [@player1, @player2]

				@tournament = Tournament.new(@players)
				@tournament.number_of_matches.should be(1)
			end
		end

		context "when an odd number of people are in the tournament" do
			it "returns the right number of rounds" do
				@player1 = Player.new("a")
				@player2 = Player.new("b")
				@player3 = Player.new("b")
				@players = [@player1, @player2, @player3]

				@tournament = Tournament.new(@players)
				@tournament.number_of_matches.should be(2)
			end
		end
	end

	describe ".start" do
		context "when an odd number of people are in the tournament" do
			it "adds a bye player" do
				@player1 = Player.new("a")
				@player2 = Player.new("b")
				@player3 = Player.new("b")
				@players = [@player1, @player2, @player3]

				@tournament = Tournament.new(@players)
				@tournament.start
				@tournament.players.length.should be(4)
			end
		end
	end

	describe ".round" do
		context "when no players are in the tournament" do
			it "raises an error" do
				pending
				@tournament = Tournament.new
				lambda { @tournament.round }.raise_error
			end
		end

		context "when no rounds exist" do
			it "raises an error" do
				pending
				@tournament = Tournament.new
				lambda { @tournament.round }.raise_error
			end
		end
	end

	describe ".create_matches" do
		before :each do
			@player1 = Player.new("1")
			@player2 = Player.new("2")
			@player3 = Player.new("3")
			@player4 = Player.new("4")

			@players = [@player1, @player2, @player3]
			@tournament = Tournament.new(@players)
		end

		it "matches up players" do
			@tournament.create_matches
			@tournament.round(0).length.should be(2)
		end

		it "creates one round" do
			@tournament.create_matches
			@tournament.rounds.length.should be(1)
		end

		it "doesn't pair players that have already played" do
			match1 = Match.new(@player1, @player2)
			match2 = Match.new(@player3, @player4)
			round = [match1, match2]
			@tournament.rounds << round
			@tournament.create_matches
			@tournament.rounds.each do | round |
				round.each do | match |
					
				end
			end
		end

	end

end