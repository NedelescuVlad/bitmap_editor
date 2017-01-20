# Default placeholder for an interpreter's user interface.
# Convenience class for not handling the case where no editor is linked to an interpreter.
class NullEditor
	def display(message)
		puts "Displayed message to null interface. #{check_interface_validity}"
	end

	def run 
		puts "Tried waiting for input from a null interface. #{check_interface_validity}"
	end

	def exit
		puts "Tried closing a null interface. #{check_interface_validity}"
	end

	private
		def check_interface_validity
			"Check that your interpreter is linked to an interface."
		end
end
