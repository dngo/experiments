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
    return 100 unless valid? #return something that will break so that north of -1 doesn't become 1
    coordinates.last.to_i
  end

  def nw
    Square.new "#{previous_column}#{row.next}"
  end

  def n
    Square.new "#{column}#{row.next}"
  end

  def ne
    Square.new "#{column.next}#{row.next}"
  end

  def e
    Square.new "#{column.next}#{row}"
  end

  def se
    Square.new "#{column.next}#{row.pred}"
  end

  def s
    Square.new "#{column}#{row.pred}"
  end

  def sw
    Square.new "#{previous_column}#{row.pred}"
  end

  def w
    Square.new "#{previous_column}#{row}"
  end

  #return an arbitary invalid column if we are at the first column
  #so it doesn't go to the end of the string
  def previous_column
    return false if column == "a"
    index = Board::COLUMNS.index(column)
    Board::COLUMNS.at(index - 1)
  end

end
