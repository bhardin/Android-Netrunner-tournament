require './spec/spec_helper'

describe Player do

	

	context "when created with a name" do
		before :each do
			# @player = Player.new("Jake Stevens")
			@player = FactoryGirl.build(:player)
		end

		it "has a name" do
			@player.name.should be
		end

	end

end