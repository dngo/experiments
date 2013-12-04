require 'spec_helper'

describe Pawn do 

  before :each do
    @piece = Pawn.new(:color => :white, :square => "d2")
  end

  it "#color" do
    @piece.color.should eql(:white)
  end

  it "#square" do
    @piece.square.coordinates.should eql("d2")
  end

  it "#possible_moves should not include current coordinates" do
    @piece.legal_moves.include?("d2").should be_false
  end

  it "#possible_moves 2 squares forward when at starting position" do
    ( %w(d3 d4) - @piece.legal_moves).should be_empty #white pawn moves n

    @piece = Pawn.new(:color => :black, :square => "d7")
    ( %w(d6 d5) - @piece.legal_moves).should be_empty #black pawn moves s
  end

  it "#possible_moves 1 squares forward when not at starting position" do
    @piece = Pawn.new(:color => :white, :square => "d2", :has_moved => true)
    @piece.legal_moves.should eql ["d3"]

    @piece = Pawn.new(:color => :black, :square => "d7", :has_moved => true)
    @piece.legal_moves.should eql ["d6"]
  end

  it "#captures diagonally"
  it "#possible_moves en passant"
  it "#promotion"
end
