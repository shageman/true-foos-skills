class GamesOfPlayerQuery
  def initialize(player)
    @player = player
  end

  def number_of_wins
    Game.non_deleted.last_month.where("(black_front_player_id = #{@player.id} OR black_back_player_id = #{@player.id} AND result IS FALSE) OR
               (yellow_front_player_id = #{@player.id} OR yellow_back_player_id = #{@player.id} AND result IS TRUE)").count
  end

  def number_of_losses
    Game.non_deleted.last_month.where("(black_front_player_id = #{@player.id} OR black_back_player_id = #{@player.id} AND result IS TRUE) OR
               (yellow_front_player_id = #{@player.id} OR yellow_back_player_id = #{@player.id} AND result IS FALSE)").count
  end
end