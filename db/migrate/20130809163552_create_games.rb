class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :white_player_id
      t.string :black_player_id
      t.string :turn
      t.string :result
      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
