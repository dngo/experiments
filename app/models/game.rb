class Game < ActiveRecord::Base
  validates_presence_of :white_player, :black_player, :board

  belongs_to :white_player, class_name: "User"
  belongs_to :black_player, class_name: "User"
  has_one :board

  #delegate :move, :to => :board
end
