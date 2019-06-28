class HardwareTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    hardware_types = HardwareType.all

    render json: hardware_types, status: :ok
  end


  def create
    return unless user_logged?

    hardware_type = HardwareType.new( hardware_type_params )

    verify_hardware_type = HardwareType.find_by(name: hardware_type_params[:name])

    unless verify_hardware_type.nil?
      render json: {'message': 'Nome de hardware já cadastrado'}, status: :internal_server_error
      return
    end


    if hardware_type.save
      render json: hardware_type, status: :ok
    else
      render json: {'message': hardware_type.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    hardware_type = HardwareType.find( params[:id] )

    render json: hardware_type, status: :ok
  end

  def update
    return unless user_logged?

    hardware_type = HardwareType.find( params[:id] )

    if hardware_type.update( hardware_type_params )
      render json: hardware_type, status: 200
    else
      render json: {'message': hardware_type.errors.full_message}, status: :internal_server_error
    end
  end

  def destroy
    return unless user_logged?

    hardware_type = HardwareType.find( params[:id])
    lot_items = LotItem.find_by(hardware_type_id: hardware_type.id )

    unless lot_items.nil?
      render json: {'message': 'O item não pode ser excluído pois existem itens cadastrados.'}, status: 401
      return
    end

    if hardware_type.delete
      render json: hardware_type, status: 200
    else
      render json: {'message': hardware_type.errors.full_message}, status: :internal_server_error
    end
  end

  private

  def hardware_type_params
    params.require(:hardware_type).permit(:name)
  end

end
