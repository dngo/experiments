require 'spec_helper'

describe Piece do 

  before :each do
    @piece = Knight.new(:color => :white, :square => "c3")
  end

  it "#color" do
    @piece.color.should eql :white
  end

  it "#square" do
    @piece.square.coordinates.should eql("c3")
  end

end
