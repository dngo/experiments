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
    def moves
      return legal_moves if legal_moves.present?
      self.legal_moves = []
      super
      self.legal_moves.flatten!
      legal_moves
    end

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
  def jumps 
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

  def moves
    self.legal_moves = jumps
  end
end

module RowColumn
  def moves
    super if defined? super
    self.legal_moves << go_dir(%w(n e s w))
  end
end

module Diagonal
  def moves
    super if defined? super
    self.legal_moves << go_dir(%w(nw ne se sw))
  end
end

module PawnMoves
  def moves 
    dir = color == :white ? "n" : "s"
    self.legal_moves << square.send(dir).coordinates
    self.legal_moves << square.send(dir).send(dir).coordinates unless has_moved?
  end
end

Piece.extend Movement
