require './app/views/command_line_interface'
require './app/interpreters/default_interpreter'

interpreter = Interpreter.new
command_line_editor = BitmapEditor.new(interpreter)
interpreter.coupled_interface = command_line_editor
command_line_editor.run
