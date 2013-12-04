module Movement
  attr_accessor :legal_moves

  def acts_as_moveable(*args)
    options = args.extract_options!
    cattr_accessor :limit

    self.limit = options[:limit].present? ? options[:limit] : 7

    include RowColumn if args.include?(:row_column)
    include Diagonal if args.include?(:diagonal)
    include PawnMoves if args.include?(:pawn_moves)
    include KnightMoves if args.include?(:knight_moves)

    include InstanceMethods
  end

  module InstanceMethods
    def go_dir(directions)
      all_squares = []
      directions.each do |dir|
        next_square = square.send(dir)
        squares = []
        while next_square.valid? && squares.count < limit
          squares << next_square.coordinates
          next_square = next_square.send(dir)
        end
        all_squares << squares
      end
      all_squares
    end
  end

end


module KnightMoves
  def possible_moves 
    squares = []
    squares << square.n.n.e
    squares << square.n.n.w
    squares << square.e.e.n
    squares << square.e.e.s
    squares << square.s.s.e
    squares << square.s.s.w
    squares << square.w.w.n
    squares << square.w.w.s
    squares.select{ |square| square.valid? }.map(&:coordinates)
  end

  def initialize(*attributes)
    super
    self.legal_moves << possible_moves
    self.legal_moves.flatten!
  end
end

module RowColumn
  def initialize(*attributes)
    super
    self.legal_moves << go_dir(%w(n e s w))
    self.legal_moves.flatten!
  end
end

module Diagonal
  def initialize(*attributes)
    super
    self.legal_moves << go_dir(%w(nw ne se sw))
    self.legal_moves.flatten!
  end
end

module PawnMoves
  def initialize(*attributes)
    super
    self.limit = has_moved? ? 1 : 2
    dir = color == :white ? %w(n) : %w(s)
    self.legal_moves << go_dir(dir)
    self.legal_moves.flatten!
  end
end

Piece.extend Movement
