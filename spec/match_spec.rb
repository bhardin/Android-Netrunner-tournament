require './spec/spec_helper'

describe Match do
	let(:player1) { FactoryGirl.build(:player)}
	let(:player2) { FactoryGirl.build(:player)}

	before :each do
		@match = Match.new(player1, player2)
	end
	
	describe "initialize" do
		it "sets player_one" do
			@match.player_one.should be
		end

		it "sets player_two" do
			@match.player_two.should be
		end
	end

	describe ".score" do
		context "when no games have been played" do
			it "score should be 0" do
				@match.score.should == 0
			end
		end
	end

	context "when calculating prestige points" do
		context "for a normal game" do
			before :each do
				@match.score_game(4, 10)
				@match.score_game(10, 5)
			end

			it "calculates the first player prestige correctly" do
				@match.player_one_prestige.should be(2)
			end

			it "calculates the second player prestige correctly" do
				@match.player_two_prestige.should be(4)
			end
		end

		context "for a complete blowout" do
			before :each do
				@match.score_game(0, 10)
				@match.score_game(0, 10)
			end

			it "calculates the first player prestige correctly" do
				@match.player_one_prestige.should be(0)
			end

			it "calculates the second player prestige correctly" do
				@match.player_two_prestige.should be(6)
			end
		end

		context "for a tied second game" do
			before :each do
				@match.score_game(4, 10)
				@match.score_game(5, 5)
			end

			it "calculates the first player prestige correctly" do
				@match.player_one_prestige.should be(1)
			end

			it "calculates the second player prestige correctly" do
				@match.player_two_prestige.should be(5)
			end
		end
	end

	describe ".score_game" do
		context "when scoring a valid first game" do
			before :each do
				@completed_match = @match.score_game(10, 5)
			end

			it "records the game" do
				@completed_match.should be
			end

			it "changes the status to game_two" do
				@match.status.should be(:game_two)
			end
		end

		context "when scoring a valid second game" do
			before :each do
				@match.score_game(4, 10)
				@second_game = @match.score_game(10, 5)
			end

			it "records the game" do
				@second_game.should be
			end

			it "changes the status to game_two" do
				@match.status.should be(:finished)
			end
		end

		context "when match is finished" do
			it "raises an error" do
				@match.stub(:status).and_return(:finished)
				expect{ @match.score_game(10,1) }.to raise_error("AlreadyFinished")
			end
		end

		context "when given a score too high" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(11,1) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(1,11) }.to raise_error("InvalidScore")
				end
			end
		end

		context "when given a score too low" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(-1,1) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(1,-1) }.to raise_error("InvalidScore")
				end
			end
		end

		context "when given a score that isn't valid" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(9,10) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(7,10) }.to raise_error("InvalidScore")
				end
			end
		end
	end

end