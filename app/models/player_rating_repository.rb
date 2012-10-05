require 'saulabs/trueskill'

class PlayerRatingRepository
  include ::Saulabs::TrueSkill

  def initialize
    @players = Player.all
    @players.map { |player|
      player.rating = Rating.new(1000.0, 100.0, 1.0)
    }
  end

  def recalculate_all_skills
    Game.all.each do |game|
      team_yellow = [find(game.yellow_front_player_id).rating, find(game.yellow_back_player_id).rating]
      team_black = [find(game.black_front_player_id).rating, find(game.black_back_player_id).rating]
      if game.result
        FactorGraph.new([team_yellow, team_black], [1, 2]).update_skills
      else
        FactorGraph.new([team_black, team_yellow], [1, 2]).update_skills
      end
    end

    save_back
  end

  private

  def find(id)
    @players.select { |player| player.id == id }.first
  end

  def save_back
    @players.each do |player|
      player.mean = player.rating.mean
      player.deviation = player.rating.deviation
      player.save!
    end
  end
end

