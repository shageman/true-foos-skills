require 'saulabs/trueskill'

module PlayerRatingRepository
  class Front < Base
    def team_yellow(game)
      [find(game.yellow_front_player_id).rating]
    end

    def team_black(game)
      [find(game.black_front_player_id).rating]
    end
  end
end