class Board
  attr_accessor :position

  STARTING_POSITION = %w(r n b q k b n r
                         p p p p p p p p
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         P P P P P P P P
                         R N B Q K B N R)

  SQUARES = %w(a1 b1 c1 d1 e1 f1 g1 h1
               a2 b2 c2 d2 e2 f2 g2 h2
               a3 b3 c3 d3 e3 f3 g3 h3
               a4 b4 c4 d4 e4 f4 g4 h4
               a5 b5 c5 d5 e5 f5 g5 h5
               a6 b6 c6 d6 e6 f6 g6 h6
               a7 b7 c7 d7 e7 f7 g7 h7
               a8 b8 c8 d8 e8 f8 g8 h8)

  #def initialize(*attributes)
  #options = attributes.extract_options!.stringify_keys
  def initialize
    self.position = {}
    SQUARES.each_with_index do |square, index|
      piece = STARTING_POSITION[index]
      position[square] = piece == "0" ? nil : piece 
    end
  end

  def pieces
    position.inject({}) do |memo, attr|
      memo[attr.first] = attr.last if attr.last.present?
      memo
    end
  end

  #todo make sure move is valid
  def move(from, to)
    self.position[to] = position[from]
    self.position[from] = 0
  end

  def to_ascii
    ascii = ""
    position.each_with_index do |square, index|
      ascii << if square.last.nil? 
         "0"
      else
         "#{square.last}"
      end
      ascii << if (index + 1) % 8 == 0  
        "\n                                "
      else
        " "
      end
    end
    ascii
  end
end
