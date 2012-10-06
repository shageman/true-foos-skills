class StatsController < ApplicationController

  http_basic_authenticate_with :name => ENV["USERNAME"], :password => ENV["PASSWORD"]

  def show
    @number_of_games = Game.count
    @number_of_yellow_wins = Game.where(result: true).count
    @number_of_black_wins = @number_of_games - @number_of_yellow_wins

    @morning_players = PlayerRatingRepository::Morning.new.recalculate_all_skills.players
    @afternoon_players = PlayerRatingRepository::Afternoon.new.recalculate_all_skills.players

    @front_players = PlayerRatingRepository::Front.new.recalculate_all_skills.players
    @back_players = PlayerRatingRepository::Back.new.recalculate_all_skills.players
  end
end
