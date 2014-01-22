class Piece
  include Movement

  attr_accessor :color, :square, :has_moved
  ATTRIBUTE_KEYS = %w(color has_moved)
  COLOR = {white: :white, black: :black}.freeze
  PIECE_KEYS = {
                  R: {class: 'Rook',   color: COLOR[:white]},
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
                  p: {class: 'Pawn',   color: COLOR[:black]}
                }.freeze

#  def initialize(args={})
#    @color = args[:color]
#    @square = args[:square]
#    @has_moved = args.fech(:square, false)
#    @movement = args[:movement]
#  end
#
#  def moves
#    movement.squares
#  end

  def initialize(*attributes)
    options = attributes.extract_options!.stringify_keys

    if square = options.delete("square")
      self.square = Square.new(square) unless square.is_a?(Square)
    end
    ATTRIBUTE_KEYS.each { |key| self.send("#{key}=", options[key]) }
  end

  def has_moved?
    has_moved
  end

  def self.from_ascii(letter)
    letter = letter.to_sym
    begin 
    klass, color = PIECE_KEYS[letter][:class].constantize, PIECE_KEYS[letter][:color]
    klass.new(:color => color)
    rescue
      raise NotImplementedError, "#{letter} not implemented"
    end
  end

  def to_ascii
    color == COLOR[:white] ? self.class::SYM : self.class::SYM.downcase
  end

end
