class Bishop < Piece
  SYM = "B"
  DIRECTIONS = %w(nw ne se sw)
  LIMIT = 8

  private
  def directions
    DIRECTIONS
  end

  def limit
    LIMIT
  end
end
