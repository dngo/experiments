require 'spec_helper'

describe Game do 

  before :each do
    white_player = mock_model(User)
    black_player = mock_model(User)
    @game = Game.new(:white_player => white_player, :black_player => black_player, :board => Board.new)
  end

  it "is valid" do
    @game.should be_valid

    bad_game = Game.new
    bad_game.should_not be_valid
  end

end
