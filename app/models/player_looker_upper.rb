
class PlayerLookerUpper
  def initialize(players)
    @players = players
  end

  def player_by_hash(player_hash)
    @players.each do |player|
      return player if player.id == player_hash['id']
    end
  end
end
