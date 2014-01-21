require 'spec_helper'

describe Board do 

  before :each do
    @board = Board.new
    @board.setup
  end

  it "#setup pieces are all in starting position" do
    @board.pieces.count.should eql(32)
    @board.to_ascii.should eql %Q{
    r n b q k b n r
    p p p p p p p p
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    P P P P P P P P
    R N B Q K B N R
    }
  end

  it "#place a piece" do
    @board = Board.new
    piece = King.new(:color => :white, :square => "d5")
    @board.place(piece)
    @board.at("d5").should eql(piece)
    @board.to_ascii
  end

  it "#at" do
    piece = @board.at("a1")
    piece.should be_a(Rook)
    piece.color.should eql(:white)
  end

  it "cannot move from an empty square" do
    expect{ @board.move("a3", "a4") }.to raise_error(NoPieceError)
  end

  it "#player cannot move out of turn" do
    @board.turn = :black
    expect{ @board.move("a2", "a3") }.to raise_error(NotPlayerTurnError)
  end

  it "#move" do
    @board.move("a2", "a3")
    @board.to_ascii.should eql %Q{
    r n b q k b n r
    p p p p p p p p
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    P 0 0 0 0 0 0 0
    0 P P P P P P P
    R N B Q K B N R
    }
  end

end
