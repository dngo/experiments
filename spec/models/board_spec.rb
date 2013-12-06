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
    @board.at("a1").should eql('R')
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
