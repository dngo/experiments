class Rook < Piece
  acts_as_moveable :row_column

  SYM = "R"
end
