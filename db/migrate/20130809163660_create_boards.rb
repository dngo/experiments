class CreateBoards < ActiveRecord::Migration
  def up
    create_table :boards do |t|
      t.string :moves
      t.string :turn
      t.string :game_id
      t.timestamps
    end
  end

  def down
    drop_table :boards
  end
end
