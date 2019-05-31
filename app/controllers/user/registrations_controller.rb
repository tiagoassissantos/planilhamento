# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  skip_before_action :verify_authenticity_token, only: [:index, :create, :update]
  skip_before_action :require_no_authentication, only: [:index, :create, :update]


  def index
    users = User.all

    render json: users, status: :ok
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.name = params[:user][:name]
    resource.cpf = params[:user][:cpf]
    resource.role = params[:user][:role]

    user = User.find_by(name: params[:user][:name])

    unless user.nil?
      render json: {"status": "error", "message": "Já existe um Usuário com o email informado."}, status: 409
    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        render json: {"status": "success", "message": "Usuário cadastrado com sucesso."}, status: 200
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      #respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    user = User.find_by(id: params[:id])
    render json: user, status: 200
  end

  # PUT /resource
  def update
    build_resource(sign_up_params)

    user = User.find_by(id: params[:id])
    user.update( user_params )
    user.password = params[:user][:password]

    if user.save
      render json: {"status": "success", "message": "Usuário cadastrado com sucesso."}, status: 200
    else
      render json: {"status": "error", "message": "Não foi possível atualizar dados."}, status: 400
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def user_params
    params.require(:user).permit(:id, :name, :cpf, :email, :role )
  end
end
