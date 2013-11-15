require 'spec_helper'

describe King do 

  before :each do
    @piece = King.new(:color => :white, :position => :a1)
  end

  it "#color" do
    @piece.color.should eql(:white)
  end

  it "#position" do
    @piece.position.should eql(:a1)
  end

  it "#to_ascii" do
    @piece.to_ascii.should eql "K"

    @piece = King.new(:color => :black, :position => :a1)
    @piece.to_ascii.should eql "k"
  end

end
