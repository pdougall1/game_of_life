require_relative '../lib/world'
require_relative '../lib/cell'

describe World do

	cell_1 = Cell.new [1,1]
	cell_2 = Cell.new [1,2]
	cell_3 = Cell.new [1,3]
	cell_4 = Cell.new [2,1]
	cell_5 = Cell.new [2,2]
	cell_6 = Cell.new [2,3]
	cell_7 = Cell.new [3,1]
	cell_8 = Cell.new [3,2]
	cell_9 = Cell.new [3,3]
	world = World.new
	subject { world.seed_with cell_1 }

	context 'when creatig the world' do

		it 'should create a new world' do
			expect(subject.class).to eq(World)
		end

		it 'should have at least one live cell' do
			expect(subject.live_cells.keys.count).to eq(1)
		end
	end

	context "when advancing to the next iteration" do

		subject { world.seed_with cell_1, cell_2, cell_3, cell_4 }
		before { @new_world = subject.tick }

		it 'should advance the world' do
			expect(subject.tick.class).to eq(World)
		end

		it 'should have a different world' do
			expect(subject).to_not eq(@new_world)
		end

		it 'should have live cells' do
			expect(@new_world.live_cells.keys.count).to be > 0
		end

		it 'all cells should be unique' do
			_world = world.seed_with cell_1, cell_1
			expect(_world.live_cells.keys.count).to eq(1)
		end

		context "when given a cell with 4 neighbors" do

			pre_tick  = world.seed_with cell_1, cell_2, cell_3, cell_4, cell_5 
			post_tick = pre_tick.tick

			it 'should have different live cells' do
				expect(pre_tick.live_cells).to_not eq(post_tick.live_cells)
			end
		end

		context 'when given a three cells adjacent to a dead cell' do
			cells = [cell_1, cell_2, cell_3, cell_4, cell_5]
			subject { world.seed_with *cells }

			it 'should have a new live cell' do
				new_cells = subject.live_cells.keep_if { |cell| !cells.include? cell }
				expect(new_cells.count).to be > 0
			end

			it 'should have a specific new cell' do
				_cells = [cell_1, cell_2, cell_9]
				_world = world.seed_with(*_cells).tick
				new_cells = _world.live_cells.values.select { |cell| !_cells.include? cell }
				puts new_cells
				expected_new_cell = Cell.new [2,2]
				expect(new_cells.include? expected_new_cell).to eq(true)
			end

		end

	end
	
end