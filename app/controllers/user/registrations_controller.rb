# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  skip_before_action :verify_authenticity_token, only: [:index, :create, :update, :update_password]
  skip_before_action :require_no_authentication, only: [:index, :create, :update, :update_password]

  def index
    return unless current_user.role == 'admin'

    users = User.all
    render json: users, status: :ok
  end

  # POST /resource
  def create
    return unless current_user.role == 'admin'

    build_resource(sign_up_params)

    resource.name = params[:user][:name]
    resource.cpf = params[:user][:cpf]
    resource.role = params[:user][:role][:role]

    if User.find_by(email: params[:user][:email])
      render json: {"status": "error", "message": "E-mail informado já está em uso"}, status: 500
      return
    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        @registry = resource.to_log
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
    return unless current_user.role == 'admin'

    user = User.find_by(id: params[:id])
    render json: user, status: 200
  end

  # PUT /resource
  def update
    return unless current_user.role == 'admin'

    build_resource(sign_up_params)

    user = User.find_by(id: params[:id])
    user.update( user_params )
    user.password = params[:user][:password]
    user.role = params[:user][:role][:role]

    if user.save
      @registry = user.to_log
      render json: {"status": "success", "message": "Usuário cadastrado com sucesso."}, status: 200
    else
      render json: {"status": "error", "message": "Não foi possível atualizar dados."}, status: 400
    end
  end

  def update_password
    return unless current_user.role == 'admin'

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


  private
  def user_params
    params.require(:user).permit(:id, :name, :cpf, :email, :role )
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirm )
  end
end
