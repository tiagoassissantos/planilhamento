# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      return render json: { success: "sucesso" }, status: 200
    end
    invalid_login_attempt
  end

  def logged
    unless current_user.nil?
      render json:  true  , status: 200
    else
      render json: false  , status: 404
    end
  end

  def get_user
    Rails.logger.info( current_user.to_json )
    render json: current_user, status: 200
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: {error: "Usuário ou senha estão errados"}, status: 401
  end
end
