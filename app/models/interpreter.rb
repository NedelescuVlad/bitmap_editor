require_relative '../views/null_editor'
require_relative 'bitmap'
# Input interpreter. Handles reading and executing a user's input and 
# sending back confirmation/error messages to the associated interface, when needed.
class Interpreter
	attr_accessor :coupled_interface

	# Couple the interpreter with a default NullInterface.
	def initialize
		@coupled_interface = NullEditor.new
		@bitmap = Bitmap.new
		# TODO: Replace flag with null bitmap object
		@image_created = false
	end

	# Parses and executes a user's command, if valid.
	def process(raw_input)
		raw_input.upcase!
		case raw_input
		  when '?' 
				show_help
			when 'X' 
				exit
			when 'C'
				issue_clear_command
			when 'S'
				issue_show_command
			when /^I \d+ \d+$/
				issue_create_command(raw_input)
			when /^L \d+ \d+ [A-Z]+$/ 
				issue_color_pixel_command(raw_input)
			when /^V \d+ \d+ \d+ [0-9A-Z]$/ 
				issue_vertical_draw_command(raw_input)
			when /^H \d+ \d+ \d+ [0-9A-Z]$/ 
				issue_horizontal_draw_command(raw_input)
			else 
				display ErrorMessages.invalid_command
		end
	end

  private

		# I M N
		def issue_create_command(confirmed_create_command)
			create_command_as_array = confirmed_create_command.split

			image_width = create_command_as_array[1].to_i
			image_height = create_command_as_array[2].to_i

			if !@bitmap.valid_create_params?(image_width, image_height)
				display ErrorMessages.invalid_create_params
				return
			end

			@bitmap.create(image_width, image_height)
			@image_created = true
		end

		# S
		def issue_show_command
			if !@image_created
				display ErrorMessages.no_image_found
				return
			end
			display @bitmap.to_s
		end

		# C
		def issue_clear_command
			if !@image_created 
				display ErrorMessages.no_image_found
				return
			end

			@bitmap.clear
		end

		# L X Y C
		def issue_color_pixel_command(confirmed_color_pixel_command)
			if !@image_created 
				display ErrorMessages.no_image_found
				return
			end
			
			command_as_array = confirmed_color_pixel_command.split
			row_pos = command_as_array[1].to_i
			col_pos = command_as_array[2].to_i
			color = command_as_array[3]

			if @bitmap.validates_row_index?(row_pos) && @bitmap.validates_col_index?(col_pos)
				@bitmap.color_pixel(row_pos, col_pos, color)
			else
				display ErrorMessages.index_out_of_bounds
			end
		end

		# V X Y1 Y2 C 
		def issue_vertical_draw_command(confirmed_vertical_draw_command)
			if !@image_created 
				display ErrorMessages.no_image_found
				return
			end

			command_as_array = confirmed_vertical_draw_command.split
			target_col = command_as_array[1].to_i
			row_index_1 = command_as_array[2].to_i
			row_index_2 = command_as_array[3].to_i
			color = command_as_array[4]

			if valid_vertical_draw_command?(target_col, row_index_1, row_index_2)
				@bitmap.vertical_draw(target_col, row_index_1, row_index_2, color)
			else
				display ErrorMessages.index_out_of_bounds
			end
		end
		
		def valid_vertical_draw_command?(target_col, row_index_1, row_index_2)
			@bitmap.validates_row_indexes?([row_index_1, row_index_2]) && @bitmap.validates_col_index?(target_col)
		end

		# H X1 X2 Y C
		def issue_horizontal_draw_command(confirmed_horizontal_draw_command)
			if !@image_created 
				display ErrorMessages.no_image_found
				return
			end

			command_as_array = confirmed_horizontal_draw_command.split
			col_index_1 = command_as_array[1].to_i
			col_index_2	= command_as_array[2].to_i
			target_row = command_as_array[3].to_i
			color = command_as_array[4]

			if valid_horizontal_draw_command?(target_row, col_index_1, col_index_2)
				@bitmap.horizontal_draw(target_row, col_index_1, col_index_2, color)
			else
				display ErrorMessages.index_out_of_bounds
			end
		end

		def valid_horizontal_draw_command?(target_row, col_index_1, col_index_2)
			@bitmap.validates_row_index?(target_row) && @bitmap.validates_col_indexes?([col_index_1, col_index_2])
		end

		# S
		def show_help
			help_text = "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
			display help_text
		end

		# Exit the program.
		def exit
			@coupled_interface.exit
		end

		# Display a message to the user interface.
		def display(message)
			@coupled_interface.display message
		end

		module ErrorMessages
			def self.no_image_found
				"Please create an image first."
			end

			def self.index_out_of_bounds
				"An index is out of bounds."
			end

			def self.invalid_create_params
				"Image needs to be at least 1 x 1 and at most 250 x 250."
			end

			def self.invalid_command
				'unrecognised command :('
			end
		end
end
