require 'spec_helper'

describe Square do 

  before :each do
    @square = Square.new("d5")
  end

  it "#valid" do
    @square.should be_valid
    Square.new("h9").should_not be_valid
    Square.new("i2").should_not be_valid
  end

  it "#column" do
    @square.column.should eql "d"
  end

  it "#row" do
    @square.row.should eql 5
  end

  it "#nw" do
    @square.nw.coordinates.should eql "c6"
  end

  it "#n" do
    @square.n.coordinates.should eql "d6"
  end

  it "#ne" do
    @square.ne.coordinates.should eql "e6"
  end

  it "#e" do
    @square.e.coordinates.should eql "e5"
  end

  it "#se" do
    @square.se.coordinates.should eql "e4"
  end

  it "#s" do
    @square.s.coordinates.should eql "d4"
  end

  it "#sw" do
    @square.sw.coordinates.should eql "c4"
  end

  it "#w" do
    @square.w.coordinates.should eql "c5"
  end
end
