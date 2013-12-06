require 'spec_helper'

describe Knight do 

  before :each do
    @piece = Knight.new(:color => :white, :square => "c3")
  end

  it "#possible_moves should not include current coordinates" do
    @piece.moves.include?("c3").should be_false
  end

  it "#has the right number of moves" do
    @piece.moves.count.should eql(8)
  end


  it "#possible_moves" do
    (@piece.moves - %w(b1 d1 a2 a4 b5 d5 e4 e2) ).should be_empty
  end

  it "#possible_moves cannot go off the board" do
    @piece = Knight.new(:color => :white, :square => "b1")
    (@piece.moves - %w(a3 c3 d2) ).should be_empty
  end

  it "is in check"
  it "move is invalid if king is in check"
  it "castles kingside"
  it "castles queenside"

end
