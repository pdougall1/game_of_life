require_relative '../lib/world'
require_relative '../lib/cell'

describe World do

	subject { World.new *cells }

	context 'when creating the world' do

		let(:cells) { [Cell.new([3, 3]), Cell.new([1,2])] }

		it 'should have the correct number live cells' do
			expect(subject.live_cells.keys.count).to eq(2)
		end
	end

	context "when given two cells with the same coordinates" do

		let(:cells) { [Cell.new([1,1]), Cell.new([1,1]), Cell.new([1,2])] }

		it 'all cells should be unique' do
			expect(subject.live_cells.keys.uniq.count).to eq(2)
		end

	end

	context "when advancing to the next iteration" do

		let(:cells) { [
			Cell.new([1,1]), 
			Cell.new([1,2]),
			Cell.new([1,3]),
			Cell.new([2,1])
		] }

		before { @new_world = subject.tick }

		it 'should advance the world' do
			expect(@new_world).to be_a(World)
		end

		it 'should have live cells' do
			expect(@new_world.live_cells.keys.count).to be > 0
		end

		context "when given a cell with 4 neighbors" do

			let(:cells) { [
				Cell.new([1,1]), 
				Cell.new([1,2]),
				Cell.new([1,3]),
				Cell.new([2,1]),
				Cell.new([2,2])
			] }

			before { @post_tick = subject.tick }

			it 'should have different live cells' do
				expect(subject.live_cells).to_not eq(@post_tick.live_cells)
			end
		end

		context 'when given a three cells adjacent to a dead cell' do

			let(:cells) { [Cell.new([1,1]), Cell.new([1,2]), Cell.new([3,3])] }

			before do 
				@new_cells = subject.tick.live_cells.values.keep_if do |cell| 
					!cells.include? cell.coordinates
				end
			end

			it 'should have a new live cell' do
				expect(@new_cells.count).to eq(1)
			end

			it 'should have a specific new cell' do
				expected_new_cell = Cell.new [2,2]
				expect(@new_cells.include? expected_new_cell).to eq(true)
			end

		end

	end
	
end