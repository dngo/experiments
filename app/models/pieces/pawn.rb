class Pawn < Piece
  SYM = "P"

  protected
  def directions
    if color == :white
      %w(n)
    elsif color == :black
      %w(s)
    end
  end

  def limit
    has_moved? ? 1 : 2
  end
end
