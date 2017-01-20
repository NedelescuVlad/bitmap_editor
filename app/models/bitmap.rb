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

	# Colors the pixel at given row and col indexes.
	def color_pixel(valid_row_index, valid_col_index, color)
		# Match between the index range implied by users and the array implementation by subtracting 1.
		row_to_color = valid_row_index - 1
		col_to_color = valid_col_index - 1

		@image[row_to_color][col_to_color] = color
	end

	# Draws a vertical line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	# The indexes are recognized as valid if they are within the boundaries of the bitmap.
	def vertical_draw(valid_target_col, valid_start_row, valid_end_row, color)
		# Swap the row indexes if needed.
		if valid_end_row < valid_start_row 
			valid_start_row, valid_end_row = valid_end_row, valid_start_row
		end

		for current_row in valid_start_row..valid_end_row 
			color_pixel(current_row, valid_target_col, color)
		end
	end

	# Draws a horizontal line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	# The indexes are recognized as valid if they are within the boundaries of the bitmap.
	def horizontal_draw(valid_target_row, valid_start_col, valid_end_col, color)
		# Swap the col indexes if needed.
		if valid_end_col < valid_start_col
			valid_start_col, valid_end_col = valid_end_col, valid_start_col
		end

		for current_col in valid_start_col..valid_end_col
			color_pixel(valid_target_row, current_col, color)
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
