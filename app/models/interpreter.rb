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
		@image_created = false
	end

	# Parses and executes a user's command, if valid.
	# Lowercase 
	def process(raw_input)
		raw_input.upcase!
		case raw_input
		  when '?' 
				show_help

			when 'X' 
				exit

			when 'C'
				@bitmap.clear

			when 'S'
				display @bitmap.to_s

			when create_command?(raw_input)
				issue_create_command(raw_input)

			when color_pixel_command?
				issue_color_pixel_command(raw_input)

			when vertical_draw_command?
				issue_vertical_draw_command(raw_input)

			when horizontal_draw_command?(raw_input)
				issue_horizontal_draw_command(raw_input)

			else 
				display 'unrecognised command :('
		end
	end

  private

	#I M N
	def create_command?(raw_input)
		/I \d \d/ =~ raw_input
	end

	def issue_create_command(confirmed_create_command)
		command_as_array = confirmed_create_command.split
		width = confirmed_create_command[1]
		height = confirmed_create_command[2]
		# not yet implemented
		# @bitmap.create(width, height)
	end

  #L X Y C
	def color_pixel_command?(raw_input)
		/L \d \d [A-Z]+/ =~ raw_input
	end

	def issue_color_pixel_command(confirmed_color_pixel_command)
		if !@image_created 
			display please_create_image_first
			return
		end
		
		command_as_array = confirmed_color_pixel_command.split
		row_pos = command_as_array[1]
		col_pos = command_as_array[2]
		color = command_as_array[3]
		# not implemented
		# @bitmap.color_pixel(row_pos, col_pos, color)
	end

	#V X Y1 Y2 C
	def vertical_draw_command?(raw_input)
		/V \d \d \d [A-Z]+/ =~ raw_input
	end

	def issue_vertical_draw_command(confirmed_vertical_draw_command)
		if !@image_created 
			display please_create_image_first
			return
		end

		command_as_array = confirmed_vertical_draw_command.split
		col_to_color = command_as_array[1]
		row_from = command_as_array[2]
		row_to = command_as_array[3]
		color = command_as_array[4]

		# @bitmap.vertical_draw(col_to_color, row_from, row_to, color)
	end

	#H X1 X2 Y C 
	def horizontal_draw_command?(raw_input)
		/H \d \d \d [A-Z]+/ =~ raw_input
	end

	def issue_horizontal_draw_command(confirmed_horizontal_draw_command)
		if !@image_created 
			display please_create_image_first
			return
		end

		command_as_array = confirmed_horizontal_draw_command.split
		col_from = command_as_array[1]
		col_to = command_as_array[2]
		row_to_color = command_as_array[3]
		color = command_as_array[4]

		# @bitmap.horizontal_draw(col_from, col_to, row_to_color, color)
	end

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

	def please_create_image_first
		"Please create an image first."
	end

	# Exit the program.
	def exit
		@coupled_interface.exit
	end

	# Display a message to the user interface.
	def display(message)
		@coupled_interface.display message
	end
end
