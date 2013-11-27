class Bishop < Piece
  acts_as_moveable :diagonal

  SYM = "B"
end
