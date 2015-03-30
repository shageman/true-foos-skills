class RankingsController < ApplicationController
  def index
    data_fetcher = DataFetcher.new
    data_fetcher.fetch_data!

    players = data_fetcher.players
    games = data_fetcher.games

    PlayerRatingCalculator.new(players).calculate_skills(games)

    @ranked_players = players.select { |p| p.rating.deviation < 250 }
    @unranked_players = players.select { |p| p.rating.deviation >= 250 }
  end
end
