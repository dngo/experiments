class Queen < Piece
  SYM = "Q"
  DIRECTIONS = %w(nw n ne e se s sw w)
  LIMIT = 8

  protected
  def directions
    DIRECTIONS
  end

  def limit
    LIMIT
  end
end
