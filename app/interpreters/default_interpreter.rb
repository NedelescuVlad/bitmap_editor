require_relative '../interpreters/default_interpreter'

class Interpreter
	attr_writer :coupled_interface

	def intialize
		@coupled_interface = NullInterface.new
	end

	def process(expression)
		case expression
		  when '?' 
				show_help
			when 'X' 
				exit
			else 
				display 'unrecognised command :('
		end
	end

  private
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

		def exit
			@coupled_interface.exit
		end

		def display(message)
			@coupled_interface.display message
		end
end
