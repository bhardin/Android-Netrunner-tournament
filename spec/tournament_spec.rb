require './spec/spec_helper'

describe Tournament do
	let(:player1) { FactoryGirl.build(:player)}
	let(:player2) { FactoryGirl.build(:player)}
	let(:player3) { FactoryGirl.build(:player)}
	let(:player4) { FactoryGirl.build(:player)}

	describe ".number_of_matches" do
		context "when an even number of people are in the tournament" do
			it "returns the right number of rounds" do
				players = [player1, player2]

				tournament = Tournament.new(players)
				tournament.number_of_matches.should be(1)
			end
		end

		context "when an odd number of people are in the tournament" do
			it "returns the right number of rounds" do
				players = [player1, player2, player3]

				tournament = Tournament.new(players)
				tournament.number_of_matches.should be(2)
			end
		end
	end

	describe ".start" do
		context "when an odd number of people are in the tournament" do
			it "adds a bye player" do
				players = [player1, player2, player3]

				tournament = Tournament.new(players)
				tournament.start
				tournament.players.length.should be(4)
			end
		end
	end

	describe ".round" do
		context "when no players are in the tournament" do
			it "raises an error" do
				pending
				tournament = Tournament.new
				lambda { tournament.round }.raise_error
			end
		end

		context "when no rounds exist" do
			it "raises an error" do
				pending
				tournament = Tournament.new
				lambda { tournament.round }.raise_error
			end
		end
	end

	describe ".create_matches" do
		before :each do
			players = [player1, player2, player3, player4]
			@tournament = Tournament.new(players)
		end

		it "is ran before game is started it raises an error" do

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
			match1 = Match.new(player1, player2)
			match2 = Match.new(player3, player4)
			round = [match1, match2]
			@tournament.rounds << round
			@tournament.create_matches
			@tournament.rounds.each do | round |
				round.each do | match |
					puts "#{match.player1.name} and #{match.player2.name}"
				end
			end
		end

	end

end