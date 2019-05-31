class DamageTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    damage_types = DamageType.all

    render json: damage_types, status: :ok
  end


  def create
    return unless user_logged?

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
    damage_types = DamageType.where( hardware_type_id: params[:hardware_type_id] )
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
