class LeaderboardController < ApplicationController

  # GET /players
  def index
    @players = Player.all.order('points desc')
    json_response(@players)
  end

  def player_params
    # whitelist params
    params.permit( :first_name, :last_name, :email, :password, :password_confirmation, :phone, :gender, :points, :coach_id, :age, :age_range)
  end
end
