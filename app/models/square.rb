class Square
  attr_accessor :coordinates

  def initialize(coordinates)
    self.coordinates = coordinates
  end

  def column
    coordinates.to_s.first
  end

  def row
    coordinates.to_s.last.to_i
  end

end
