module Movement
  attr_accessor :moves

  #TODO pass in board so we can determine moves based on position of other pieces
  def self.build(piece)
    @moves = get_moves(piece)
  end

  def self.get_moves(piece)
    moves = []
    piece.directions.each do |direction|
      moves << go_direction(piece, direction)
    end
    moves.flatten
  end

  def self.go_direction(piece, direction)
    moves = []
    next_square = piece.square.send(direction)
    while next_square.valid? && moves.count < piece.limit
      moves << next_square.coordinates
      next_square = next_square.send(direction)
    end
    moves
  end

end
