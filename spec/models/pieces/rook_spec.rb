require 'spec_helper'

describe Rook do 

  before :each do
    @piece = Rook.new(:color => :white, :square => "d5")
  end

  it "#color" do
    @piece.color.should eql(:white)
  end

  it "#square" do
    @piece.square.coordinates.should eql("d5")
  end

  it "#has the right number of moves" do
    @piece.moves.count.should eql(14)
  end

  it "#possible_moves should not include current coordinates" do
    @piece.moves.include?("d5").should be_false
  end

  it "#possible_moves row and column" do
    ( %w(d1 d2 d3 d4 d6 d7 d8) - @piece.moves).should be_empty #column
    ( %w(a5 b5 c5 e5 f5 g5 h5) - @piece.moves).should be_empty #row
  end

end
