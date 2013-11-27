class Piece
  include Movement

  attr_accessor :color, :square
  ATTRIBUTE_KEYS = %w(color)

  def initialize(*attributes)
    options = attributes.extract_options!.stringify_keys
    ATTRIBUTE_KEYS.each do |key|
      self.send("#{key}=", options[key])
    end
    self.square = Square.new options["square"] unless square.is_a?(Square)
    self.legal_moves = []
  end

  def to_s
    color == :white ? self.class::SYM : self.class::SYM.downcase
  end

end
