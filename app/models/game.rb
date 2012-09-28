class Game < ActiveRecord::Base
  attr_accessible :black_1_player_id, :black_2_player_id, :result, :yellow_1_player_id, :yellow_2_player_id
  belongs_to :black_1_player, foreign_key: :black_1_player_id, class_name: "Player"
  belongs_to :black_2_player, foreign_key: :black_2_player_id, class_name: "Player"
  belongs_to :yellow_1_player, foreign_key: :yellow_1_player_id, class_name: "Player"
  belongs_to :yellow_2_player, foreign_key: :yellow_2_player_id, class_name: "Player"
end
