class GamesController < ApplicationController

  before_filter :inject_services

  # GET /games
  def index
    @games = Game.all
    @players = Player.order("mean DESC").all
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
        @player_rating_repository.recalculate_all_skills.save_back
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
      @player_rating_repository.recalculate_all_skills.save_back
      redirect_to games_url, notice: 'Game was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /games/1
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    @player_rating_repository.recalculate_all_skills.save_back

    redirect_to games_url
  end

  private

  def inject_services
    @player_rating_repository = PlayerRatingRepository::Base.new
  end
end
