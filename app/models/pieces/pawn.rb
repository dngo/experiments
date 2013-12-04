class Pawn < Piece
  acts_as_moveable :forward, :limit => 1

  SYM = "P"
end
