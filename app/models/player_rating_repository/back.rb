require 'saulabs/trueskill'

module PlayerRatingRepository
  class Back < Base
    def team_yellow(game)
      [find(game.yellow_back_player_id).rating]
    end

    def team_black(game)
      [find(game.black_back_player_id).rating]
    end
  end
end