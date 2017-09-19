class PlayersController < ApplicationController
	before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index
    @players = Player.all
    json_response(@players)
  end

  # POST /players
  # def create
  #   @player = Player.create!(player_params)
  #   json_response(@player, :created)
  # end

  # GET /players/:id
  def show
    json_response(@player)
  end

  # PUT /players/:id
  def update
    @player.update(player_params)
    head :no_content
  end

  # DELETE /players/:id
  # def destroy
  #   @player.destroy
  #   head :no_content
  # end

  private

  # def player_params
  #   # whitelist params
  #   params.permit( :first_name, :last_name, :email, :password, :password_confirmation, :phone, :gender, :points, :coach_id, :age, :age_range)
  # end

  def set_player
    @player = Player.find(params[:id])
  end
end
