class Game < ActiveRecord::Base
  validates_presence_of :white_player, :black_player, :board, :turn

  belongs_to :white_player, class_name: "User"
  belongs_to :black_player, class_name: "User"
  has_one :board

  before_validation(on: :create) do
    self.turn ||= :white
  end

end
