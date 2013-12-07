require 'spec_helper'

describe Board do 

  before :each do
    @board = Board.new
  end

  it "#new sets up correctly" do
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

  it "#at" do
    piece = @board.at("a1")
    piece.should be_a(Rook)
    piece.color.should eql(:white)
  end

  it "cannot move from an empty square" do
    expect{ @board.move("a3", "a4") }.to raise_error(NoPieceError)
  end

  it "#turn player can only move if it is their turn" do
    @board.turn = :black
    expect{ @board.move("a2", "a3") }.to raise_error(NotYourTurnError)
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
