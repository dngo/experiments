require 'spec_helper'

describe King do 

  before :each do
    @piece = King.new(:color => :white, :square => :d5)
  end

  it "#color" do
    @piece.color.should eql(:white)
  end

  it "#square" do
    @piece.square.coordinates.should eql(:d5)
  end

  it "#to_s" do
    @piece.to_s.should eql "K"

    @piece = King.new(:color => :black, :square => :a1)
    @piece.to_s.should eql "k"
  end

  it "#possible_moves should not include current coordinates" do
    @piece.legal_moves.include?(:d5).should be_false
  end

  it "#possible_moves row and column" do
    ([:d1, :d2, :d3, :d4, :d6, :d7, :d8] - @piece.legal_moves).should be_empty #column
    ([:a5, :b5, :c5, :e5, :f5, :g5, :h5] - @piece.legal_moves).should be_empty #row
  end

  it "#possible_moves diagonally" do
    #([:a8, :b7, :c6, :e4, :f3, :g2, :h1] - @piece.legal_moves).should be_empty #column
    #([:a2, :b3, :c4, :e6, :f7, :g8] - @piece.legal_moves).should be_empty #row
  end
#
#  it "#possible_moves only 1 square" do
#  end

end
