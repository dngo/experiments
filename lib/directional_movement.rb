module DirectionalMovement
  attr_accessor :moves, :directions, :limit

  #TODO pass in board so we can determine moves based on position of other pieces
  def self.build(square, directions, limit)
    @directions = directions
    @limit = limit
    @moves = get_moves(square)
  end

  def self.get_moves(square)
    moves = []
    @directions.each do |direction|
      moves << moves_by_direction(square, direction)
    end
    moves.flatten
  end

  def self.moves_by_direction(square, direction)
    moves = []
    next_square = square.send(direction)
    while next_square.valid? && moves.count < @limit
      moves << next_square.coordinates
      next_square = next_square.send(direction)
    end
    moves
  end

end
