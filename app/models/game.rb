class Game < ActiveRecord::Base
  attr_accessible :black_front_player_id, :black_back_player_id, :result, :yellow_front_player_id, :yellow_back_player_id
  belongs_to :black_front_player, foreign_key: :black_front_player_id, class_name: "Player"
  belongs_to :black_back_player, foreign_key: :black_back_player_id, class_name: "Player"
  belongs_to :yellow_front_player, foreign_key: :yellow_front_player_id, class_name: "Player"
  belongs_to :yellow_back_player, foreign_key: :yellow_back_player_id, class_name: "Player"

  def self.non_deleted
    where("deleted_at is null")
  end

  def destroy
    return true if deleted_at
    self.deleted_at = Time.now
    save(validate: false)
  end
end
