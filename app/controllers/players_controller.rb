class PlayersController < ApplicationController

  http_basic_authenticate_with :name => ENV["USERNAME"], :password => ENV["PASSWORD"], :except => [:index]

  # GET /players.json
  def index
    @ranked_players = Player.ranked_players.all
    @unranked_players = Player.unranked_players.all
    @news = News.order("id DESC").all

    respond_to do |format|
      format.html
      format.json { render json: @players }
    end
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to players_path, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  def update
    @player = Player.find(params[:id])

    if @player.update_attributes(params[:player])
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render action: "edit"
    end
  end
end
