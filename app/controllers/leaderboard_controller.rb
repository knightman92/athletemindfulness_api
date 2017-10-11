class LeaderboardController < ApplicationController

  # GET /players
  def index
  	if params[:coach_id] != nil and params[:age_range] != nil and params[:gender] != nil
      @players = Player.where("coach_id = ? AND age_range = ? AND gender = ?", params[:coach_id], params[:age_range], params[:gender]).order('points desc')
    elsif params[:coach_id] != nil and params[:gender] != nil
      @players = Player.where("coach_id = ? AND gender = ?", params[:coach_id], params[:gender]).order('points desc')
    elsif params[:gender] != nil and params[:age_range] != nil
      @players = Player.where("gender = ? AND age_range = ?", params[:gender], params[:age_range]).order('points desc')
    elsif params[:coach_id] != nil and params[:age_range] != nil
      @players = Player.where("coach_id = ? AND age_range = ?", params[:coach_id], params[:age_range]).order('points desc')
    elsif params[:coach_id] != nil
      @players = Player.where("coach_id = ?", params[:coach_id]).order('points desc')
    elsif params[:age_range] != nil
      @players = Player.where("age_range = ?", params[:age_range]).order('points desc')
    elsif params[:gender] != nil
      @players = Player.where("gender = ?", params[:gender]).order('points desc')
    else
    	@players = Player.all.order('points desc')
    end
    json_response(@players)
  end

  def player_params
    # whitelist params
    params.permit( :first_name, :last_name, :email, :password, :password_confirmation, :phone, :gender, :points, :coach_id, :age, :age_range)
  end
end
