require 'spec_helper'

describe King do 

  before :each do
    @piece = King.new(:color => :white, :square => "d5")
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
    @piece.moves.count.should eql(8)
  end

  it "#possible_moves row and column" do
    ( %w(c5 e5) - @piece.moves).should be_empty #row
    ( %w(d4 d6) - @piece.moves).should be_empty #column
  end

  it "#possible_moves diagonally" do
    ( %w(e4 c6) - @piece.moves).should be_empty #ne sw
    ( %w(c4 e6) - @piece.moves).should be_empty #nw se
  end

   it "#possible_moves only 1 square" do
    ( %w(d4 e5 d6 c5 c4 e4 e6 c6) - @piece.moves).should be_empty #nw se
   end

  it "is in check"
  it "move is invalid if king is in check"
  it "castles kingside"
  it "castles queenside"


end
