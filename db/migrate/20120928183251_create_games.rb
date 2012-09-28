class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :black_1_player_id
      t.integer :black_2_player_id
      t.integer :yellow_1_player_id
      t.integer :yellow_2_player_id
      t.boolean :result

      t.timestamps
    end
  end
end
