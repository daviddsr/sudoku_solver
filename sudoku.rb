
#!/usr/bin/ruby

require 'sqlite3'

HINTS = [
          {id: 2, row: 1, column: 2, sudoku_row: 1, sudoku_column: 1, number: 6, mark_ups: [6]},
          {id: 4, row: 1, column: 4, sudoku_row: 1, sudoku_column: 2, number: 1, mark_ups: [1]},
          {id: 6, row: 1, column: 6, sudoku_row: 1, sudoku_column: 2, number: 4, mark_ups: [4]},
          {id: 9, row: 2, column: 3, sudoku_row: 1, sudoku_column: 1, number: 8, mark_ups: [8]},
          {id: 10, row: 2, column: 4, sudoku_row: 1, sudoku_column: 2, number: 3, mark_ups: [3]},
          {id: 12, row: 2, column: 6, sudoku_row: 1, sudoku_column: 2, number: 5, mark_ups: [5]},
          {id: 13, row: 3, column: 1, sudoku_row: 1, sudoku_column: 1, number: 2, mark_ups: [2]}
        ]

begin

  SudokuSolver.generate_square_hints(HINTS)
  SudokuSolver.generate_suares
    
  db = SQLite3::Database.new "sudoku.db"
    
  stm = db.prepare "SELECT * FROM Cars LIMIT 5" 
  rs = stm.execute 
  
  rs.each do |row|
      puts row.join "\s"
  end
    
rescue SQLite3::Exception => e 
    
  puts "Exception occurred"
  puts e
    
ensure
	puts "done"
  stm.close if stm
  db.close if db
end