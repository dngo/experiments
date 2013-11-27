class Queen < Piece
  acts_as_moveable :diagonal, :row_column

  SYM = "Q"
end
