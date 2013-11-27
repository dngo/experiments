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

  it "#to_s" do
    @piece.to_s.should eql "B"

    @piece = Bishop.new(:color => :black, :square => "a1")
    @piece.to_s.should eql "b"
  end

  it "#possible_moves should not include current coordinates" do
    @piece.legal_moves.include?("d5").should be_false
  end

  it "#possible_moves diagonally" do
    ( %w(a8 b7 c6 e4 f3 g2 h1) - @piece.legal_moves).should be_empty #ne sw
    ( %w(a2 b3 c4 e6 f7 g8) - @piece.legal_moves).should be_empty #nw se
  end


end
