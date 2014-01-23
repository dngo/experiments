class King < Piece
  SYM = "K"
  DIRECTIONS = %w(nw n ne e se s sw w)
  LIMIT = 1

  private
  def directions
    DIRECTIONS
  end

  def limit
    LIMIT
  end
end
