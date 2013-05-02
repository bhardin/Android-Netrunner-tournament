require './spec/spec_helper'


describe "Something Else" do
	(1..16).each do | x |
		let("player#{x}".to_sym) { FactoryGirl.build(:player)}
	end

	before :each do
		@players = [player1, player2, player3, player4, player5, player6, player7, player8, player9, player10]
		@players = @players | [player11, player12, player13, player14, player15, player16]
		@tournament = Tournament.new(@players)
	end


	it "does this" do
		@tournament.start
		@tournament.players.each do | x |
			puts "P: #{x.name}"
			x.opponents
		end
	end
	
end
