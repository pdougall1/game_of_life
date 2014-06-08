
class World

	def seed_with *cells
		@live_cells = Hash.new
		cells.each { |cell| @live_cells[cell.coordinates] = cell }
		self
	end

	def live_cells
		@live_cells
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
		cells = selected_cells + resurected_cells
		new_world = World.new 
		new_world.seed_with *cells
	end

end
