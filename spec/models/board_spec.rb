require 'spec_helper'

describe Board do 

  before :each do
    @board = Board.new
  end

  it "#new sets up correctly" do
    @board.pieces.count.should eql(32)
  end

  it "#move" do
  end

  it "#to_ascii" do
    @board.to_ascii.should eql "r n b q k b n r
                                p p p p p p p p
                                0 0 0 0 0 0 0 0
                                0 0 0 0 0 0 0 0
                                0 0 0 0 0 0 0 0
                                0 0 0 0 0 0 0 0
                                P P P P P P P P
                                R N B Q K B N R
                                "
  end

end
