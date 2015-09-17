class Sudoku
  attr_reader :board
  def initialize(board_string)
    @board = board_string.split(//)
  end

  def solve
    return self if solved?
    return false unless valid?
    next_cell = board.index("-")
    possible_solutions_at(next_cell).each do |attempt|
      board[next_cell] = attempt
      answer = Sudoku.new(board.join('')).solve
      return answer if answer
    end
    false
  end

  def possible_solutions_at(index)
    [*"1".."9"] - (row_at(index) | col_at(index) | box_at(index))
  end

  def row_at(ind)
    rows[ind / 9]
  end

  def col_at(ind)
    columns[ind % 9]
  end

  def box_at(ind)
    boxes[ box_index_for(ind) ]
  end

  def solved?
    !board.include?("-")
  end

  def valid?
    no_dupes?(rows) && no_dupes?(columns) && no_dupes?(boxes)
  end

  def no_dupes?(set)
    set.all? do |subset|
      no_blanks = subset.reject {|cell| cell == "-"}
      no_blanks.length == no_blanks.uniq.length
    end
  end

  def rows
     @rows ||= board.each_slice(9).to_a
  end

  def columns
    @cols ||= rows.transpose
  end

  def boxes
    @boxes ||= board.each_with_index
    .with_object(Array.new(9){[]}) do |(cell, ind), boxes|
      box_index = box_index_for(ind)
      boxes[box_index] << cell
    end
  end

  def box_index_for(index)
    (index / 9 / 3 * 3) + (index % 9 / 3)
  end

  # Returns a string representing the current state of the board
  def to_s
    rows.map {|row| row.join(" ") }.join("\n")
  end
end
