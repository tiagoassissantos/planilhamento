class DamageTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    damage_types = DamageType.all.order(hardware_type_id: :asc, name: :asc)

    render json: damage_types, status: :ok
  end


  def create
    return unless user_logged?

    verify_damage_type = DamageType.find_by(hardware_type_id: damage_type_params[:hardware_type_id], name: damage_type_params[:name])
    unless verify_damage_type.nil?
      render json: {'message': 'Tipo de Avaria já utilizado'}, status: :internal_server_error
      return
    end

    damage_type = DamageType.new( damage_type_params )
    if damage_type.save
      render json: damage_type, status: :ok
    else
      render json: {'message': damage_type.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    damage_type = DamageType.find( params[:id])

    if damage_type.delete
      render json: damage_type, status: 200
    else
      render json: {'message': damage_type.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?
    damage_type = DamageType.find( params[:id] )
    render json: damage_type, status: :ok
  end

  def by_hardware_type
    return unless user_logged?
    damage_types = DamageType.where( hardware_type_id: params[:hardware_type_id] ).order(name: :asc)
    render json: damage_types, status: :ok
  end

  def by_hardware_name
    return unless user_logged?
    hardware_type = HardwareType.find_by(name: params[:hardware_type_name])
    damage_types = DamageType.where( hardware_type_id: hardware_type.id )
    render json: damage_types, status: :ok
  end

  def update
    return unless user_logged?

    damage_type = DamageType.find( params[:id] )

    if damage_type.update( damage_type_params )
      render json: damage_type, status: 200
    else
      render json: {'message': damage_type.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def damage_type_params
    params.require(:damage_type).permit(:name, :hardware_type_id)
  end
end
