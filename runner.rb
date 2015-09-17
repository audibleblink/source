require_relative 'sudoku'

board_string = File.readlines('sudoku_puzzles.txt').first.chomp

File.readlines('sudoku_puzzles.txt').each do |puzzle|
  start = Time.now
  puts Sudoku.new(puzzle.chomp).solve
  puts Time.now - start
  puts
end
