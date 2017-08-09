require 'spec_helper'
require './sudoku_solver'

describe "SudokuSolver" do
	before(:each) do
		@db = SQLite3::Database.open "sudoku.db"
		@db.execute "DROP TABLE IF EXISTS Squares"
		@hints = [
			{id: 2, row: 1, column: 2, sudoku_row: 1, sudoku_column: 1, number: 6, mark_ups: [6]},
			{id: 4, row: 1, column: 4, sudoku_row: 1, sudoku_column: 2, number: 1, mark_ups: [1]},
			{id: 6, row: 1, column: 6, sudoku_row: 1, sudoku_column: 2, number: 4, mark_ups: [4]},
			{id: 9, row: 2, column: 3, sudoku_row: 1, sudoku_column: 1, number: 8, mark_ups: [8]},
			{id: 10, row: 2, column: 4, sudoku_row: 1, sudoku_column: 2, number: 3, mark_ups: [3]},
			{id: 12, row: 2, column: 6, sudoku_row: 1, sudoku_column: 2, number: 5, mark_ups: [5]},
			{id: 13, row: 3, column: 1, sudoku_row: 1, sudoku_column: 1, number: 2, mark_ups: [2]}
		]
	end
	
	describe "generate_squares_hints" do
		it "inserts new squares in database" do
			SudokuSolver.generate_squares_hints(@hints)

			squares = @db.execute('select * from Squares')
			
			expect(squares.size).to eq(7)
		end

	end

	describe "generate_squares" do
		before(:each) do
			SudokuSolver.generate_squares_hints(@hints)
		end
		it "creates sudoku squares from 0 to 81 except if there is already one in database" do
			SudokuSolver.generate_squares

			squares = @db.execute('select * from Squares')

			squares_ids = @db.execute <<-SQL
				SELECT Id FROM Squares;
				SQL

			squares_ids

			squares_ids.uniq!
			
			expect(squares.size).to eq(81)
			expect(squares_ids.size).to eq(81)
		end

	end

	describe "set_markups" do
		before(:each) do
			SudokuSolver.generate_squares_hints(@hints)
			SudokuSolver.generate_squares
		end

		xit "sets possible winners for each square" do
			SudokuSolver.set_markups

			markups_first_square = @db.execute('select markups from Squares where Id=1')

			expect(markups_first_square).to eq([3,5,7,9])
		end
	end

end