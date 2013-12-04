class Pawn < Piece
  acts_as_moveable :pawn_moves

  SYM = "P"
end
