require 'spec_helper'

describe Bishop do 

  before :each do
    @piece = Bishop.new(:color => :white, :square => "d5")
  end

  it "#color" do
    @piece.color.should eql(:white)
  end

  it "#square" do
    @piece.square.coordinates.should eql("d5")
  end

  it "#possible_moves should not include current coordinates" do
    @piece.moves.include?("d5").should be_false
  end

  it "#has the right number of moves" do
    @piece.moves.count.should eql(13)
  end

  it "#possible_moves diagonally" do
    ( %w(a8 b7 c6 e4 f3 g2 h1) - @piece.moves).should be_empty #ne sw
    ( %w(a2 b3 c4 e6 f7 g8) - @piece.moves).should be_empty #nw se
  end


end
