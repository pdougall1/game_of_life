require_relative '../lib/cell'

describe Cell do 

	subject { Cell.new [3, 3] }

	context 'when creating a cell' do

		it 'should create a new cell' do
			expect(subject.class).to eq(Cell)
		end

		it 'should have neighbors' do
			expect(subject.neighbors.is_a? Enumerable).to eq(true)
		end

		it 'should have coordinates' do
			expect(subject.coordinates.class).to eq(Array)
		end

	end

	context "it's neighbors" do
		it 'should not include itself' do
			expect(subject.neighbors.include? subject).to_not eq(true)
		end

		it 'should total to eight' do
			expect(subject.neighbors.count).to eq(8)
		end
	end

end