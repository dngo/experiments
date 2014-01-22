class Knight < Piece
  SYM = "N"

  #override superclass method
  def moves 
    @moves = []
    @moves << square.n.n.e
    @moves << square.n.n.w
    @moves << square.e.e.n
    @moves << square.e.e.s
    @moves << square.s.s.e
    @moves << square.s.s.w
    @moves << square.w.w.n
    @moves << square.w.w.s
    @moves.select{ |square| square.valid? }.map(&:coordinates)
  end

end
