class Player
	attr_accessor :name, :prestige_points

	def initialize(name=nil)
		@name = name
		@prestige_points = 0
		@opponents = []
	end

	def add_opponent(player)
		@opponents << player
	end

	def opponents
		@opponents.join(",")
	end

	def played?(player)
		@opponents.include?(player)
	end
end