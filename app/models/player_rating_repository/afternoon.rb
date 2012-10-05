require 'saulabs/trueskill'

module PlayerRatingRepository
  class Afternoon < Base
    def games
      #games in afternoon MST -> DB times are in UTC
      Game.non_deleted.where("date_part('hour', created_at) < 6 OR date_part('hour', created_at) >= 18").all
    end
  end
end
