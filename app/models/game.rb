
class Game
  #{"id"=>1, "in_progress"=>false, "team_1"=>{"defense"=>"The Lyon", "offense"=>"The Gern"}, "team_1_score"=>5, "team_2"=>{"defense"=>"After School Special", "offense"=>"Jitters McSplashyPants"}, "team_2_score"=>2}
  attr_accessor :id, :in_progress, :team_1, :team_1_score, :team_2, :team_2_score

  def initialize(player_looker_upper, json)
    @id = json["id"]
    @team_1 = player_looker_upper.player_by_hash(json["team_1"]["defense"]), player_looker_upper.player_by_hash(json["team_1"]["offense"])
    @team_2 = player_looker_upper.player_by_hash(json["team_2"]["defense"]), player_looker_upper.player_by_hash(json["team_2"]["offense"])

    @team_1_score = json["team_1_score"]
    @team_2_score = json["team_2_score"]
  end

  def has_result?
    @team_1_score && @team_2_score && true
  end

  def team1_won?
    @team_1_score > @team_2_score
  end
end

