class Bishop < Piece
  SYM = "B"
  DIRECTIONS = %w(nw ne se sw)
  LIMIT = 8

  def directions
    DIRECTIONS
  end

  def limit
    LIMIT
  end
end
