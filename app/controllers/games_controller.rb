class GamesController < ApplicationController
  def index
    data_fetcher = DataFetcher.new
    data_fetcher.fetch_data!

    @games = data_fetcher.games
    @games.sort! { |a,b| a.id <=> b.id }
  end
end
