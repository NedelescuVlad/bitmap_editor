require_relative '../models/interpreter'

# Command line interface for editing a bitmap.
# Once #run is called, the BitmapEditor:
# 1. Asks the user for input.
# 2. Passes the input to the interpreter.
# 3. (Possibly) prints out a response message (error/notification).
# 4. Loops.
class BitmapEditor

	# Initializes the BitmapEditor and associates it with an interpreter.
	def initialize(interpreter)
		interpreter.coupled_interface = self
		@interpreter = interpreter
	end
	
	# Runs the bitmap editor. 
	# Fetches user input and parses it until an exit command is issued.
  def run
    @running = true
    display 'INFO - Type ? for Help'
    while @running
      print '> '
			#begin 
				expression = gets.chomp
				@interpreter.process(expression)
			#rescue Interrupt, StandardError => e
				## exits cleanly on Ctrl-D and Ctrl-C
				#exit
			#end
    end
  end

	# Displays a message to the CLI.
	# Used for both status and error messages.
	def display(message)
		puts message
	end

	# Stops listening for input and exits the program.
	def exit
		display 'Goodbye!'
		@running = false
	end
end
