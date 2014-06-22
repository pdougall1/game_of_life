require_relative '../lib/cell'

describe Cell do 

	subject { Cell.new [3, 3] }

	context 'when creating a cell' do

		it 'should have neighbors' do
			expect(subject.neighbors).to be_kind_of(Enumerable)
		end

		it 'should have coordinates set of two' do
			expect(subject.coordinates).to eq([3, 3]) 
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