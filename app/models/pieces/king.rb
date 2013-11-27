class King < Piece
  acts_as_moveable :diagonal, :row_column, :limit => 1

  SYM = "K"
end
