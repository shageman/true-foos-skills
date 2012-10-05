require 'saulabs/trueskill'

module PlayerRatingRepository
  class Base
    include ::Saulabs::TrueSkill

    def initialize
      @players = Player.all
      @players.map { |player|
        player.rating = Rating.new(1000.0, 100.0, 1.0)
      }
    end

    def recalculate_all_skills
      games.each do |game|
        team_yellow = team_yellow(game)
        team_black = team_black(game)
        if game.result
          FactorGraph.new([team_yellow, team_black], [1, 2]).update_skills
        else
          FactorGraph.new([team_black, team_yellow], [1, 2]).update_skills
        end
      end
      @players.each do |player|
        player.mean = player.rating.mean
        player.deviation = player.rating.deviation
      end
      self
    end

    def save_back
      @players.each &:save!
    end

    def players
      @players.sort do |player1, player2|
        player2.mean <=> player1.mean
      end
    end

    private

    def games
      Game.non_deleted.all
    end

    def team_yellow(game)
      [find(game.yellow_front_player_id).rating, find(game.yellow_back_player_id).rating]
    end

    def team_black(game)
      [find(game.black_front_player_id).rating, find(game.black_back_player_id).rating]
    end

    def find(id)
      @players.select { |player| player.id == id }.first
    end
  end
end
