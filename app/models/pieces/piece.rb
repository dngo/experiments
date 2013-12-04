class Piece
  include Movement

  attr_accessor :color, :square, :has_moved
  ATTRIBUTE_KEYS = %w(color)

  def initialize(*attributes)
    options = attributes.extract_options!.stringify_keys
    ATTRIBUTE_KEYS.each do |key|
      self.send("#{key}=", options[key])
    end
    self.legal_moves = []
    self.square = Square.new options["square"] unless square.is_a?(Square)
    self.has_moved = false
  end

  def to_s
    color == :white ? self.class::SYM : self.class::SYM.downcase
  end

  def has_moved?
    has_moved
  end

end
