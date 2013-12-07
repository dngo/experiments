class Piece
  include Movement

  attr_accessor :color, :square, :has_moved
  ATTRIBUTE_KEYS = %w(color has_moved)

  def initialize(*attributes)
    options = attributes.extract_options!.stringify_keys
    ATTRIBUTE_KEYS.each do |key|
      self.send("#{key}=", options[key])
    end
    self.square = Square.new options["square"] unless square.is_a?(Square)
  end

  def has_moved?
    has_moved
  end

  def self.from_ascii(letter)
    case letter
    when "r"
      Rook.new(:color => :black)
    when "n"
      Knight.new(:color => :black)
    when "b"
      Bishop.new(:color => :black)
    when "q"
      Queen.new(:color => :black)
    when "k"
      King.new(:color => :black)
    when "p"
      Pawn.new(:color => :black)
    when "p"
      Pawn.new(:color => :white)
    when "R"
      Rook.new(:color => :white)
    when "N"
      Knight.new(:color => :white)
    when "B"
      Bishop.new(:color => :white)
    when "Q"
      Queen.new(:color => :white)
    when "K"
      King.new(:color => :white)
    when "P"
      Pawn.new(:color => :white)
    else
      nil
    end
  end

end
