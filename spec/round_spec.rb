require './spec/spec_helper'

describe Round do
	let(:player1) { FactoryGirl.build(:player)}
	let(:player2) { FactoryGirl.build(:player)}

	before :each do
		@round = Round.new(1)
	end

	describe ".add_match" do
		context "when trying to add a match" do
			it "is successful" do
				pending
				match = Match.new(player1, player2)
				@round.add_match(match)
			end
		end

		context "when trying to add something that isn't a match" do
			it "raises an error" do
				expect { @round.add_match("adsfasdf") }.to raise_error("NotMatch")
			end
		end
	end

end