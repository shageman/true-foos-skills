class DataFetcher
  attr_reader :players, :games

  def fetch_data!
    games_url = 'http://new-foosboard-api.cfapps.io/games'
    players_url = 'http://new-foosboard-api.cfapps.io/players'

    players_json = get_json(players_url)["players"]
    games_json = get_json(games_url)["games"]

    @players = players_json.inject([]) do |memo, player_json|
      memo << Player.new(player_json)
      memo
    end

    player_looker_upper = PlayerLookerUpper.new(players)

    @games = games_json.inject([]) do |memo, game_json|
      memo << Game.new(player_looker_upper, game_json)
      memo
    end
  end


  private

  def get_json(url)
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

end