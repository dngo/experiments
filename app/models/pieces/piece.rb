class Piece
  attr_accessor :color, :position
  ATTRIBUTE_KEYS = %w(color position)

  def initialize(*attributes)
    options = attributes.extract_options!.stringify_keys
    ATTRIBUTE_KEYS.each do |key|
      self.send("#{key}=", options[key])
    end
  end

  def to_ascii
    color == :white ? self.class::SYM : self.class::SYM.downcase
  end

end
