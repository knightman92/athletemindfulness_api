class PlayersController < ApplicationController
	before_action :set_player, only: [:show, :update, :destroy]
  before_action :authenticate_player_with_token!, only: [:create, :show, :update, :destroy]



  # GET /players
  def index
    if params[:coach_id] != nil and params[:age_range] != nil and params[:gender] != nil
      @players = Player.where("coach_id = ? AND age_range = ? AND gender = ?", params[:coach_id], params[:age_range], params[:gender])
    elsif params[:coach_id] != nil and params[:gender] != nil
      @players = Player.where("coach_id = ? AND gender = ?", params[:coach_id], params[:gender])
    elsif params[:gender] != nil and params[:age_range] != nil
      @players = Player.where("gender = ? AND age_range = ?", params[:gender], params[:age_range])
    elsif params[:coach_id] != nil and params[:age_range] != nil
      @players = Player.where("coach_id = ? AND age_range = ?", params[:coach_id], params[:age_range])
    elsif params[:coach_id] != nil
      @players = Player.where("coach_id = ?", params[:coach_id])
    elsif params[:age_range] != nil
      @players = Player.where("age_range = ?", params[:age_range])
    elsif params[:gender] != nil
      @players = Player.where("gender = ?", params[:gender])
    else
      @players = Player.all
    end
    json_response(@players)
  end

  # POST /players
  def create
    @player = Player.create!(player_params)
    json_response(@player, :created)
  end

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
  def destroy
    @player.destroy
    head :no_content
  end

  private

  def player_params
    # whitelist params
    params.permit( :first_name, :last_name, :email, :password, :password_confirmation, :phone, :gender, :points, :coach_id, :age, :age_range)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
