require './spec/spec_helper'

describe Tournament do
	let(:player1) { FactoryGirl.build(:player)}
	let(:player2) { FactoryGirl.build(:player)}
	let(:player3) { FactoryGirl.build(:player)}
	let(:player4) { FactoryGirl.build(:player)}

	describe ".number_of_matches" do
		context "when an even number of people are in the tournament" do
			before :each do
				@players = [player1, player2]
			end

			it "returns the right number of rounds" do
				tournament = Tournament.new(@players)
				tournament.number_of_matches.should be(1)
			end
		end

		context "when an odd number of people are in the tournament" do
			before :each do
				@players = [player1, player2, player3]
			end

			it "returns the right number of rounds" do
				tournament = Tournament.new(@players)
				tournament.number_of_matches.should be(2)
			end
		end
	end

	describe ".start" do
		context "when an odd number of people are in the tournament" do
			before :each do
				@players = [player1, player2, player3]
				@tournament = Tournament.new(@players)
			end

			it "adds a bye player" do
				@tournament.start
				@tournament.players.length.should be(4)
			end
		end
	end

	describe ".round" do
		context "when tournament isn't started" do
			it "raises an error" do
				tournament = Tournament.new
				expect { tournament.round }.to raise_error("NotStarted")
			end
		end

		it "returns the last round played" do
			@players = [player1, player2]
			@tournament = Tournament.new(@players)
			@tournament.start
		end
	end

	describe ".create_matches" do
		before :each do
			@players = [player1, player2, player3, player4]
			@tournament = Tournament.new(@players)
		end

		context "when called before tournament is started" do
			it "raises an error" do
				expect { @tournament.create_matches }.to raise_error("NotStarted")
			end
		end

		context "when tournament is started" do
			before :each do
				@tournament.start
			end

			it "matches up players" do
				@tournament.create_matches
				@tournament.rounds.length.should be(1)
			end

			it "doesn't pair players that have already played" do
				match1 = Match.new(player1, player2)
				match2 = Match.new(player3, player4)
				round = [match1, match2]
				@tournament.rounds << round
				match1.score_game(10, 1)
				match1.score_game(10, 1)
				match2.score_game(10, 1)
				match2.score_game(10, 1)
				@tournament.stub(:seed_round).and_return(@players)
				@tournament.finalize_round
				
				#puts round.inspect
				#puts "-----------"
				#puts round.inspect

				@tournament.round.should_not be(round)

			end
		end
	end

end