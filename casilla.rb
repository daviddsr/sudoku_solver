class Casilla

	attr_accessor :number
	attr_accessor :vertical_square
	attr_accessor :horizontal_square
	attr_accessor :linea
	attr_accessor :columna


	def initialize(vertical, horizontal, linea, columna)
		@vertical_square = vertical
		@horizontal_square = horizontal
		@linea = linea
		@columna = columna
	end
end