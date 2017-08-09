require "sqlite3"

class SudokuSolver

	SUDOKU_COLUMN = { 1 => [1,2,3,10,11,12,19,20,21,28,29,30,37,38,39,46,47,48,55,56,57,64,65,66,73,74,75], 
										2 => [4,5,6,13,14,15,22,23,24,31,32,33,40,41,42,49,50,51,58,59,60,67,68,69,76,77,78], 
										3 => [7,8,9,16,17,18,25,26,27,34,35,36,43,44,45,52,53,54,61,62,63,70,71,72,79,80,81] 
									}

	COLUMNS = [1,2,3,4,5,6,7,8,9]

	class << self



		#HINTS = [{id: 18, sudoku_row: 1, sudoku_column: 1, row: 1, column: 1, number: 3, mark_ups: [3] }]

		def generate_squares
			db = SQLite3::Database.new "sudoku.db"
			(1..81).each do |i|
				unless db.execute("select 1 from Squares where Id = ?", i).length > 0
					id = i
					sudoku_row = set_sudoku_row(i)
					sudoku_column = set_sudoku_column(i)
					row = set_row(i)
					column = set_column(i)
					markups = []
					db.execute("INSERT INTO Squares (Id, sudoku_row, sudoku_column, row, column, markups) 
	            				VALUES (?, ?, ?, ?, ?, ?)", [id, sudoku_row, sudoku_column, row, column, markups])
				end
			end
		end

		def generate_squares_hints(squares)
			db = SQLite3::Database.new "sudoku.db"

			db.execute <<-SQL
			  create table Squares (
			  	Id, int,
			    winner int,
			    sudoku_row int,
			    sudoku_column int,
			    row int,
			    column int,
			    markups varchar(9)
			  );
			SQL


			squares.each do |square|
			  db.execute("INSERT INTO Squares (Id, winner, sudoku_row, sudoku_column, row, column, markups) 
            				VALUES (?, ?, ?, ?, ?, ?, ?)", [square[:id], 
																										square[:number],
																										square[:sudoku_row], 
																										square[:sudoku_column], 
																										square[:row], 
																										square[:column], 
																										square[:mark_ups].to_s])

			end

		end

		def set_markups
			
		end

		def set_sudoku_row(i)
			value = (i / 27.to_f).ceil
			return value
		end

		def set_sudoku_column(i)
			SUDOKU_COLUMN.each do |key, value|
				return key if value.include?(i)
			end
		end

		def set_row(i)
			value = (i / 9.to_f).ceil
			return value
		end

		def set_column(i)
			counter = 1
			COLUMNS.each do |number|
				return number if i == counter
				counter += 1
				redo if number == 9
			end
		end

	end
end