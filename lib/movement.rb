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
    self.legal_moves.flatten!.map!(&:to_sym)
    self.legal_moves.delete square.coordinates #piece's current coordinate is not a legal move
  end
end

module Diagonal
  def northeast_squares
    squares = []
    next_square = square
    while true
      next_square = Square.new "#{next_square.column.next}#{next_square.row.pred}"
      squares << next_square.coordinates
      break if next_square.column == "h" || next_square.row == 1
    end
    squares
  end

  def northwest_squares
    squares = []
    next_square = square
    while true
      column = Board::COLUMNS.at((Board::COLUMNS.rindex(next_square.column) - 1))
      next_square = Square.new "#{column}#{next_square.row.pred}"
      squares << next_square.coordinates
      break if next_square.column == "a" || next_square.row == 1
    end
    squares
  end

  def southwest_squares
    squares = []
    next_square = square
    while true
      column = Board::COLUMNS.at((Board::COLUMNS.rindex(next_square.column) - 1))
      next_square = Square.new "#{column}#{next_square.row.next}"
      squares << next_square.coordinates
      break if next_square.column == "a" || next_square.row == 8
    end
    squares
  end

  def southeast_squares
    squares = []
    next_square = square
    while true
      next_square = Square.new "#{next_square.column.next}#{next_square.row.next}"
      squares << next_square.coordinates
      break if next_square.column == "h" || next_square.row == 8
    end
    squares
  end

  def initialize(*attributes)
    super
    self.legal_moves << (northeast_squares + southwest_squares + northwest_squares + southeast_squares)
    self.legal_moves.flatten!.map!(&:to_sym)
    self.legal_moves.delete square.coordinates #piece's current coordinate is not a legal move
  end
end


Piece.extend Movement
