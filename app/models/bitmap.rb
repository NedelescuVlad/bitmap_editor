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
