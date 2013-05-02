## This simulates everything necessary for a 16 person tournament.

require './spec/spec_helper'

describe "Big Tournament" do
	(1..16).each do | x |
		let("player#{x}".to_sym) { FactoryGirl.build(:player)}
	end

	before :each do
		@players = [player1, player2, player3, player4, player5, player6, player7, player8, player9, player10]
		@players = @players | [player11, player12, player13, player14, player15, player16]
		@tournament = Tournament.new(@players)
	end

	it "should have 16 players" do
		@tournament.number_of_players.should be(16)
	end

	it "should have 8 matches" do
		@tournament.number_of_matches.should be(8)
	end

	describe "before the tournament has started" do
		it "has a status of not started" do
			@tournament.status.should  be(:not_started)
		end
	end

	describe "once the tournament has started" do
		before do
			@tournament.start
		end

		it "changes the tournament status to running" do
			@tournament.status.should  be(:running)
		end

		it "creates the first round" do
			@tournament.rounds.length.should be(1)
		end

		describe "the first round" do
			it "has the right number of matches" do
				@tournament.round.matches.length.should be(@tournament.number_of_matches)
			end
		end
	end

	describe "after the first round" do
		before do
			@tournament.start
			score_round(@tournament.round)
		end

		describe "when starting the next round" do
			it "seeds players according to prestige" do
				@tournament.finalize_round
				#puts @tournament.players[0].opponents
				# @tournament.players.should == @tournament.players.sort { |x,y| y.prestige_points <=> x.prestige_points }
			end
		end
	end
end

def score_round(round)
	round.matches.each do | match |
		first_player_score_game_one = rand(0..6)
		second_player_score_game_one = 10
		first_player_score_game_two = rand(0..6)
		second_player_score_game_two = rand(0..6)

		match.score_game(first_player_score_game_one, second_player_score_game_one)
		match.score_game(first_player_score_game_two, second_player_score_game_two)
	end
end
