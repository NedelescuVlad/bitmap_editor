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
	def color_pixel(row_index, col_index, color)

	end

	# Draws a vertical line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	def vertical_draw(target_col, row_from, row_to, color)

	end

	# Draws a horizontal line in the given column between the given row indexes.
	# The order in which the indexes are passed does not matter.
	def horizontal_draw(target_row, col_from, col_to, color)

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
