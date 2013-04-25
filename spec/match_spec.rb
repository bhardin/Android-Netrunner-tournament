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

	describe ".score_game" do
		context "when given valid items" do
			it "records the game" do
				@match.score_game(1, 10, 5).should be
			end
		end

		context "when given a score too high" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(1,11,1) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(1,1,11) }.to raise_error("InvalidScore")
				end
			end
		end

		context "when given a score too low" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(1,-1,1) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(1,1,-1) }.to raise_error("InvalidScore")
				end
			end
		end

		context "when given a score that isn't valid" do
			context "for player 1" do
				it "returns an error" do
					expect{ @match.score_game(1,9,10) }.to raise_error("InvalidScore")
				end
			end

			context "for player 2" do
				it "returns an error" do
					expect{ @match.score_game(1,7,10) }.to raise_error("InvalidScore")
				end
			end
		end
	end

end