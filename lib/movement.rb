module Movement
  attr_accessor :squares

  #TODO pass in board so we can determine moves based on position of other pieces
  def self.build(piece)
    @squares = get_moves(piece)
  end

  def self.get_moves(piece)
    squares = []
    piece.directions.each do |direction|
      squares << go_direction(piece, direction)
    end
    squares.flatten
  end

  def self.go_direction(piece, direction)
    squares = []
    next_square = piece.square.send(direction)
    while next_square.valid? && squares.count < piece.limit
      squares << next_square.coordinates
      next_square = next_square.send(direction)
    end
    squares
  end

end
