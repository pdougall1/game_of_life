require 'set'

class Cell < Struct.new :coordinates

	def neighbors
		(left..right).flat_map do |x|
			(up..down).map do |y|
				Cell.new [x, y]
			end
		end.to_set.delete(self)
	end

	private

	def left
		coordinates[0] - 1
	end

	def right
		coordinates[0] + 1
	end

	def up
		coordinates[1] - 1 
	end

	def down
		coordinates[1] + 1
	end

end