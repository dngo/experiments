module Movement
  def acts_as_moveable(*args)
    options = args.extract_options!
    cattr_accessor :legal_moves
    self.legal_moves = [] 

    if args.include?(:row_column)
      include RowColumn
      RowColumn.send :initialize
    end

    if args.include?(:diagonal)
      include Diagonal
      Diagonal.send :initialize
    end

    #include InstanceMethods
  end

  module InstanceMethods
    #def move(string)
      #write_attribute(self.class.yaffle_text_field, string.to_squawk)
    #end
  end
end

module RowColumn
  def row_squares
    ('a'..'h').inject([]){ |sum, column| sum << "#{column}#{square.row}" }
  end

  def column_squares
    (1..8).inject([]){ |sum, row| sum << "#{square.column}#{row}" }
  end

  def initialize(*attributes)
    super
    self.legal_moves << (row_squares + column_squares)
    self.legal_moves.flatten!
    self.legal_moves.delete square.coordinates #piece's current coordinate is not a legal move
  end
end

module Diagonal
  def diagonal_squares
    %w(nw ne se sw).inject([]) do |squares, dir|
      next_square = square.send(dir)
      while next_square.valid?
        squares << next_square.coordinates
        next_square = next_square.send(dir)
      end
      squares
    end
  end

  def initialize(*attributes)
    super
    self.legal_moves << diagonal_squares
    self.legal_moves.flatten!
  end
end


Piece.extend Movement
