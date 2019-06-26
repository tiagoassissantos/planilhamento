# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  skip_before_action :verify_authenticity_token, only: [:index, :create, :update, :update_password]
  skip_before_action :require_no_authentication, only: [:index, :create, :update, :update_password]


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

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        #sign_up(resource_name, resource)
        render json: {"status": "success", "message": "Usuário cadastrado com sucesso."}, status: 200
      else
        expire_data_after_sign_in!
        render json: {"status": "error", "message": "Erro ao cadastrar usuário."}, status: 500
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
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

  def update_password
    params = password_params
    user = User.find_by(id: current_user.id)

    unless params[:password] == params[:password_confirm]
      render json: {"status": "error", "message": "Confirmação de senha incorreta.", status: 500}
      return
    end

    if params[:password].length < 6
      render json: {"status": "error", "message": "A senha deve possuir no mínimo 6 caracteres.", status: 500}
      return
    end

    unless user.valid_password?(params[:current_password])
      render json: {"status": "error", "message": "Não foi possível alterar sua senha, digite corretamente sua senha atual.", status: 403}
    else
      if user.update_attributes(:password => params[:password])
        render json: {"status": "success", "message": "Senha alterada com sucesso."}, status: 200
      end
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

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirm )
  end
end
