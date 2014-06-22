
class World

	attr_reader :live_cells

	def initialize *cells
		@live_cells = cells.reduce(Hash.new) do |_cells, cell|
			_cells[cell.coordinates] = cell
			_cells
		end
		self		
	end

	def is_alive? cell
		!!live_cells[cell.coordinates]
	end

	def is_dead? cell
		!live_cells[cell.coordinates]		
	end

	def live_neighbors cell
		cell.neighbors.keep_if do |cell| 
			live_cells[cell.coordinates]
		end
	end

	def selected_cells
		live_cells.values.select do |cell|
			(cell.neighbors & live_cells.values).count.between?(2, 3)
		end
	end

	def resurected_cells
		live_cells.values.reduce([]) do |acc, cell|
			dead_cells = cell.neighbors.select { |c| is_dead? c }
			dead_cells.each do |d_cell|
				acc << d_cell if live_neighbors(d_cell).count == 3
			end
			acc
		end.uniq
	end

	def tick
		# tick just needs to return a new instance of World with the evolved set of cells
		# this feels like some sort of interesting recursion
		World.new *(selected_cells + resurected_cells)
	end

end
