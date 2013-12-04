class Knight < Piece
  acts_as_moveable :knight_moves

  SYM = "N"
end
