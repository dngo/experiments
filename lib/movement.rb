module Movement
  def acts_as_moveable(*args)
    options = args.extract_options!
    cattr_accessor :legal_moves
    self.legal_moves = [] 
    include RowColumn if args.include?(:row_column)
    include Diagonal if args.include?(:diagonal)
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

  def self.included(base)
    base.class_exec do
      def initialize(*attributes)
        super
        self.legal_moves << (row_squares + column_squares)
        self.legal_moves.flatten!.map!(&:to_sym)
        debugger
        self.legal_moves.delete square.coordinates #piece's current coordinate is not a legal move
      end
    end
  end
end

module Diagonal
  def northeast_squares
    squares = []
    next_square = square
    while true
      next_square = Square.new "#{next_square.column.next}#{next_square.row.next}"
      squares << next_square.coordinates
      break if next_square.column == "h" || next_square.row == 1
    end
    squares
  end

  def southwest_squares
    #coordinates
  end

  def self.included(base)
    base.class_exec do
      def initialize(*attributes)
        super
        debugger
        self.legal_moves << (northeast_squares)
        self.legal_moves.flatten!.map!(&:to_sym)
        self.legal_moves.delete square.coordinates #piece's current coordinate is not a legal move
      end
    end
  end
end


Piece.extend Movement
