include Exceptions

class Board < ActiveRecord::Base
  attr_accessor :piece_list
  validates_presence_of :turn
  belongs_to :game

  COLUMNS = "abcdefgh"
  STARTING_POSITION = %w(r n b q k b n r
                         p p p p p p p p
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         0 0 0 0 0 0 0 0
                         P P P P P P P P
                         R N B Q K B N R)

  SQUARES = %w(a8 b8 c8 d8 e8 f8 g8 h8
               a7 b7 c7 d7 e7 f7 g7 h7
               a6 b6 c6 d6 e6 f6 g6 h6
               a5 b5 c5 d5 e5 f5 g5 h5
               a4 b4 c4 d4 e4 f4 g4 h4
               a3 b3 c3 d3 e3 f3 g3 h3
               a2 b2 c2 d2 e2 f2 g2 h2
               a1 b1 c1 d1 e1 f1 g1 h1)
  
  after_initialize do
    self.turn ||= Piece::COLOR[:white]
    self.piece_list = {}
  end

  def setup
    SQUARES.each_with_index do |square, index|
      piece = Piece.from_ascii(STARTING_POSITION[index]) unless STARTING_POSITION[index] == "0"
      piece_list[square] = piece if piece
    end
  end

  def place(piece)
    raise ArgumentError.new("no coordinates for piece") if piece.square.nil?
    piece_list[piece.square.coordinates] = piece
  end

  def at(coordinates)
    piece_list[coordinates]
  end

  def pieces
    piece_list.inject({}) do |memo, attr|
      memo[attr.first] = attr.last if attr.last.present?
      memo
    end
  end

  #todo make sure move is valid
  def move(from, to)
    raise NoPieceError.new("Attempted to move from an empty square") if at(from).nil?
    raise NotPlayerTurnError.new("#{turn}'s turn") unless at(from).color == turn
    self.piece_list[to] = piece_list[from]
    self.piece_list.delete(from)
    #toggle turn
  end

  def to_ascii
    string = "\n    "
    SQUARES.each_with_index do |square, index|
      string << if piece_list[square].nil? 
         "0"
      else
         piece_list[square].to_ascii
      end
      string << if (index + 1) % 8 == 0  
        "\n    "
      else
        " "
      end
    end
    string
  end
end

#  @bitboards[WHITE_PAWNS]   = 0b0000000000000000000000000000000000000000000000001111111100000000
#  @bitboards[WHITE_ROOKS]   = 0b0000000000000000000000000000000000000000000000000000000010000001
#  @bitboards[WHITE_KNIGHTS] = 0b0000000000000000000000000000000000000000000000000000000001000010
#  @bitboards[WHITE_BISHOPS] = 0b0000000000000000000000000000000000000000000000000000000000100100
#  @bitboards[WHITE_QUEENS]  = 0b0000000000000000000000000000000000000000000000000000000000001000
#  @bitboards[WHITE_KING]    = 0b0000000000000000000000000000000000000000000000000000000000010000
#  @bitboards[BLACK_PAWNS]   = 0b0000000011111111000000000000000000000000000000000000000000000000
#  @bitboards[BLACK_ROOKS]   = 0b1000000100000000000000000000000000000000000000000000000000000000
#  @bitboards[BLACK_KNIGHTS] = 0b0100001000000000000000000000000000000000000000000000000000000000
#  @bitboards[BLACK_BISHOPS] = 0b0010010000000000000000000000000000000000000000000000000000000000
#  @bitboards[BLACK_QUEENS]  = 0b0000100000000000000000000000000000000000000000000000000000000000
#  @bitboards[BLACK_KING]    = 0b0001000000000000000000000000000000000000000000000000000000000000
#  @bitboards[ENPASSANT]     = 0
#  @bitboards[CAN_CASTLE]    = 0x000F # 1111
