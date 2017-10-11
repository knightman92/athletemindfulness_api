class Players::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include Accessible
  before_action :check_user, :except=>[:new, :create, :destroy]
  skip_before_action :verify_signed_out_user, only: :destroy
  # before_action :authenticate_player!, only: [:update, :destroy]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    player_password = params[:session][:password]
    player_email = params[:session][:email]
    player = player_email.present? && Player.find_by(email: player_email)

    if player
      if player.valid_password? player_password
        sign_in player, store: false
        player.generate_authentication_token!
        player.save
        render json: player, status:200
      else
        render json: { message: "Invalid email or password" }, status: 422
      end
    else
      render json: { message:"Invalid email or password" }, status: 422
    end
  end

  # DELETE /resource/sign_out
  def destroy
    player = Player.find_by(auth_token: params[:auth_token])
    player.auth_token = nil
    player.save
    head 204
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
