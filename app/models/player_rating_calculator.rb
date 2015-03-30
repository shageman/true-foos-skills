class PlayerRatingCalculator
  def initialize(players)
    @players = players
  end

  def calculate_skills(games)
    games.each do |game|
      if game.has_result?
        if game.team1_won?
          Saulabs::TrueSkill::FactorGraph.new([game.team_1.map(&:rating), game.team_2.map(&:rating)], [1, 2]).update_skills
        else
          Saulabs::TrueSkill::FactorGraph.new([game.team_2.map(&:rating), game.team_1.map(&:rating)], [1, 2]).update_skills
        end
      end
    end
  end
end
