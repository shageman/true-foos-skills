require 'saulabs/trueskill'


class GamesController < ApplicationController
  include ::Saulabs::TrueSkill
  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        recalculate_all_skills
        format.html { redirect_to games_url, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(params[:game])
      recalculate_all_skills
      redirect_to games_url, notice: 'Game was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /games/1
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    recalculate_all_skills

    redirect_to games_url
  end

  private

  class PlayersRepo
    include ::Saulabs::TrueSkill

    def initialize
      @players = Player.all
      @players.map { |player|
        player.rating = Rating.new(1000.0, 100.0, 1.0)
      }
    end

    def find(id)
      @players.select { |player| player.id == id }.first
    end

    def save_back
      @players.each do |player|
        player.mean = player.rating.mean
        player.deviation = player.rating.deviation
        player.save!
      end
    end
  end

  def recalculate_all_skills
    pr = PlayersRepo.new

    Game.all.each do |game|
      team_yellow = [pr.find(game.yellow_front_player_id).rating, pr.find(game.yellow_back_player_id).rating]
      team_black = [pr.find(game.black_front_player_id).rating, pr.find(game.black_back_player_id).rating]
      if game.result
        FactorGraph.new([team_yellow, team_black], [1, 2]).update_skills
      else
        FactorGraph.new([team_black, team_yellow], [1, 2]).update_skills
      end
    end

    pr.save_back
  end
end
