class Player
	attr_accessor :name, :prestige_points

	def initialize(name=nil)
		@name = name
		@prestige_points = 0
	end
end