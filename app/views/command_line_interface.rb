require_relative '../interpreters/default_interpreter'

# Command line interface for editing a bitmap.
# Once #run is called, the BitmapEditor:
# 1. Asks the user for input.
# 2. Passes the input to the interpreter.
# 3. (Possibly) prints out a response message (error/notification).
# 4. Loops.
class BitmapEditor

	def initialize(interpreter)
		@interpreter = interpreter
	end
	
  def run
    @running = true
    display 'INFO - Type ? for Help'
    while @running
      print '> '
			begin 
				expression = gets.chomp
				@interpreter.process(expression)
			rescue Interrupt, StandardError => e
				# exit cleanly
				exit
			end
    end
  end

	def display(message)
		puts message
	end

	def exit
		display 'Goodbye!'
		@running = false
	end
end
