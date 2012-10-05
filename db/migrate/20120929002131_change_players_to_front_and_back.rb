class ChangePlayersToFrontAndBack < ActiveRecord::Migration
  def change
    rename_column :games, :black_1_player_id, :black_front_player_id
    rename_column :games, :black_2_player_id, :black_back_player_id
    rename_column :games, :yellow_1_player_id, :yellow_front_player_id
    rename_column :games, :yellow_2_player_id, :yellow_back_player_id
  end
end
