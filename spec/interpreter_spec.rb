require_relative 'spec_helper'
require_relative '../app/interpreters/interpreter'
require_relative '../app/views/null_editor'

describe Interpreter do

	before do
		@interpreter = Interpreter.new
	end

	context "without a user interface" do
		it "should have a NullObject user interface" do
			@interpreter.coupled_interface.class.should == NullEditor
		end
	end

	context "with a user interface" do
		@interpreter.coupled_interface = BitmapEditor.new(@interpreter)
		it "shuld have a BitmapEditor user interface" do
			@interpreter.coupled_interface.class.should == BitmapEditor
		end
	end
end
