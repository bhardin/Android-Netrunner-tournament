require './spec/spec_helper'

describe Player do
	let(:player1) { FactoryGirl.build(:player)}
	let(:player2) { FactoryGirl.build(:player)}
	

	context "when created with a name" do
		before :each do
			# @player = Player.new("Jake Stevens")
			@player = FactoryGirl.build(:player)
		end

		it "has a name" do
			@player.name.should be
		end

	end

	describe ".played?" do
		context "when has played with player" do
			it "returns true" do
				player1.add_opponent(player2)
				player1.played?(player2).should be_true
			end
		end

		context "when hasn't played with player" do
			it "returns false" do
				player1.played?(player2).should be_false
			end
		end		
	end

end