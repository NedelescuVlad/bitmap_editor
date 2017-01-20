# Bitmap class for representing a bit image.
class Bitmap

	# Creates an empty bit image with given dimensions.
	def create(width, height)
		@image = Array.new(width) { Array.new(height, 0) } 
		@width = width
		@height = height
	end

	# String representation of the bit image.
	def to_s
		to_return = ""
		for row in 0...@height
			for col in 0...@width
				to_return << @image[row][col].to_s
			end
			to_return << $/
		end
		to_return
	end

	# Colors the pixel at given row and col intedexes.
	def color_pixel(valid_row_index, valid_col_index, color)
		# Match between the index range a user uses and the array implementation by subtracting 1.
		row_to_color = valid_row_index - 1
		col_to_color = valid_col_index - 1

		@image[row_to_color][col_to_color] = color
	end

	# Draws a vertical line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	# The indexes are recognized as valid if they are within the boundaries of the bitmap.
	def vertical_draw(valid_target_col_index, valid_start_row_index, valid_end_row_index, color)
		# Swap the rows if the 'to' row is less than the 'from' row
		if valid_row_to < valid_row_from 
			valid_row_from = valid_row_from + valid_row_to
			valid_row_to = valid_row_from - valid_row_to
			valid_row_from = valid_row_from - valid_row_to
		end
	end

	# Draws a horizontal line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	# The indexes are recognized as valid if they are within the boundaries of the bitmap.
	def horizontal_draw(valid_target_row, valid_col_from, valid_col_to, color)
		# Swap the cols if the 'to' col is less than the 'from' col.
		if valid_col_to < valid_col_from
			valid_col_from = valid_col_from + valid_col_to
			valid_col_to = valid_col_from - valid_col_to
			valid_col_from = valid_col_from - valid_col_to
		end
	end

	# Fills the bit image with 0s.
	def clear
		for row in 0...@height
			for col in 0...@width
				@image[row][col] = 0
			end
		end
	end

	# Checks if a create command's proposed dimensions are valid.
	def valid_create_params?(width, height)
		lower_bound = 1
		upper_bound = 250

		(width >= lower_bound && width <= upper_bound) &&
		(height >= lower_bound && height <= upper_bound)
	end
end
