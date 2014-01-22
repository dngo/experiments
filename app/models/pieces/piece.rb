class Piece
  COLOR = {white: :white, black: :black}.freeze
  PIECE_KEYS = {  R: {class: 'Rook',   color: COLOR[:white]},
                  N: {class: 'Knight', color: COLOR[:white]},
                  B: {class: 'Bishop', color: COLOR[:white]},
                  Q: {class: 'Queen',  color: COLOR[:white]},
                  K: {class: 'King',   color: COLOR[:white]},
                  P: {class: 'Pawn',   color: COLOR[:white]},
                  r: {class: 'Rook',   color: COLOR[:black]},
                  n: {class: 'Knight', color: COLOR[:black]},
                  b: {class: 'Bishop', color: COLOR[:black]},
                  q: {class: 'Queen',  color: COLOR[:black]},
                  k: {class: 'King',   color: COLOR[:black]},
                  p: {class: 'Pawn',   color: COLOR[:black]}  }.freeze

  attr_accessor :color, :square, :has_moved, :moves

  def initialize(args={})
    @color = args[:color]
    @square = args[:square]
    self.square = args[:square]
    @has_moved = args.fetch(:has_moved, false)
  end

  def moves
    @moves ||= Movement.build(self)
  end

  def has_moved?
    has_moved
  end

  def self.from_ascii(letter)
    letter = letter.to_sym
    klass, color = PIECE_KEYS[letter][:class].constantize, PIECE_KEYS[letter][:color]
    klass.new(:color => color)
  end

  def to_ascii
    color == COLOR[:white] ? self.class::SYM : self.class::SYM.downcase
  end

  protected
  def square=(square)
    @square = square.is_a?(Square) ? square : Square.new(square)
  end

end
