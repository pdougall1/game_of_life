
require 'stringio'

require_relative '../lib/world'
require_relative '../lib/cell'
require_relative '../lib/game'

describe Game do 

	# not quite sure how to test the IO from the console.

	# def get_coordinates
	#   $stdin.gets.chomp
	# end

	# before do
	# 	$stdin = StringIO.new("[1,2], [2,2], [3,1]")
	# end

	# after do
	# 	$stdin = STDIN
	# end

	# it 'should be able to start' do
	# 	expect(get_coordinates).to be == "[1,2], [2,2], [3,1]"
	# end

end
