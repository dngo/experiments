class King < Piece
  acts_as_moveable :diagonal, :row_column, :limit => 1

  SYM = "K"
  VALUE = 1000
end
