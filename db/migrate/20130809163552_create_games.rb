class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :white
      t.string :black
      t.string :moves
      t.string :result
      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
