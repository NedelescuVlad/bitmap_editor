require './app/views/bitmap_editor'
require './app/models/interpreter'

interpreter = Interpreter.new
command_line_editor = BitmapEditor.new(interpreter)
command_line_editor.run
