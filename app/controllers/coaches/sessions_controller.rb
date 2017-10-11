class Coaches::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include Accessible
  before_action :check_user, :except=>[:new, :create, :destroy]
  skip_before_action :verify_signed_out_user, only: :destroy

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    coach_password = params[:session][:password]
    coach_email = params[:session][:email]
    coach = coach_email.present? && Coach.find_by(email: coach_email)

    if coach
      if coach.valid_password? coach_password
        sign_in coach, store: false
        coach.generate_authentication_token!
        coach.save
        render json: coach, status:200
      else
        render json: { message: "Invalid email or password" }, status: 422
      end
    else
      render json: { message: "Invalid email or password" }, status: 422
    end
  end

  # DELETE /resource/sign_out
  def destroy
    coach = Coach.find_by(auth_token: params[:auth_token])
    coach.auth_token = nil
    coach.save
    head 204
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
