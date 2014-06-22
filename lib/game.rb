require './world'
require './cell'

class Game

	attr_accessor :coords

	def initialize
		@coords = []
	end

	def start
		input = ''
		loop do 
			if @coords.empty?
				puts "Start me off by giving some coordinates one set at a time."
			end
			puts "Give me a set like '1, 2'"
			unless @coords.empty?
				puts "or set me loose by giving me 'GO'"
			end
			input = gets.strip
			if input.downcase.include? 'go'
				puts "\n"
				puts "\n"
				puts "Here we go!"
				break 
			end
			coords_arr = input.split(',')
			first = coords_arr[0].delete(',').to_i
			second = coords_arr[1].delete(',').to_i
			if first && second
				@coords << [first, second]
				@coords.uniq!
				puts "Now we've got #{@coords}"
			else
				puts "I didn't get that, let's try again."
			end
			puts ""
			puts ''
		end
		@world = World.new *new_cells
		start_ticking
	end

	def new_cells
		@coords.map { |coords| Cell.new coords }
	end

	def start_ticking
		loop do
			@world = @world.tick # I need to be updating the insance of world.  I don't think I was doing that before.
			# need to test that the instance has different cells
			puts "NEW VALUES : #{@world.live_cells.values}"
			sleep 0.5
		end
	end

end

Game.new.start
