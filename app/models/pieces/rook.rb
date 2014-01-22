class Rook < Piece
  SYM = "R"
  DIRECTIONS = %w(n e s w)
  LIMIT = 8

  def directions
    DIRECTIONS
  end

  def limit
    LIMIT
  end
end
