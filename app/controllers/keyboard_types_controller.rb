class KeyboardTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    keyboard_types = KeyboardType.all

    render json: keyboard_types, status: :ok
  end


  def create
    return unless user_logged?

    verify_keyboard_type = KeyboardType.find_by(name: keyboard_type_params[:name])
    unless verify_keyboard_type.nil?
      render json: {'message': 'Tipo de teclado já utilizado'}, status: :internal_server_error
      return
    end

    keyboard_type = KeyboardType.new( keyboard_type_params )
    if keyboard_type.save
      render json: keyboard_type, status: :ok
    else
      render json: {'message': keyboard_type.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    keyboard_type = KeyboardType.find( params[:id])
    lot_items = LotItem.find_by(keyboard_type_id: keyboard_type.id )

    unless lot_items.nil?
      render json: {'message': 'O item não pode ser excluído pois existem itens cadastrados.'}, status: 401
      return
    end

    if keyboard_type.delete
      render json: keyboard_type, status: 200
    else
      render json: {'message': keyboard_type.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    keyboard_type = KeyboardType.find( params[:id] )

    render json: keyboard_type, status: :ok
  end


  def update
    return unless user_logged?

    keyboard_type = KeyboardType.find( params[:id] )

    if keyboard_type.update( keyboard_type_params )
      render json: keyboard_type, status: 200
    else
      render json: {'message': keyboard_type.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def keyboard_type_params
    params.require(:keyboard_type).permit(:name)
  end
end
