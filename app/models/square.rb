class Square
  attr_accessor :coordinates

  def initialize(coordinates)
    self.coordinates = coordinates
  end

  def valid?
    Board::SQUARES.include? coordinates
  end

  def column
    coordinates.first
  end

  def row
    coordinates.last.to_i
  end

  def nw
    Square.new "#{previous_column}#{row.pred}"
  end

  def n
    Square.new "#{column}#{row.pred}"
  end

  def ne
    Square.new "#{column.next}#{row.pred}"
  end

  def e
    Square.new "#{column.next}#{row}"
  end

  def se
    Square.new "#{column.next}#{row.next}"
  end

  def s
    Square.new "#{column}#{row.next}"
  end

  def sw
    Square.new "#{previous_column}#{row.next}"
  end

  def w
    Square.new "#{previous_column}#{row}"
  end

  def previous_column
    Board::COLUMNS.at((Board::COLUMNS.rindex(column) - 1))
  end

end
