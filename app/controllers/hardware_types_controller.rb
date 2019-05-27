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

    if hardware_type.save
      render json: hardware_type, status: :ok
    else
      render json: {'message': hardware_type.errors.full_message}, status: :internal_server_errir
    end
  end


  def show
    return unless user_logged?

    hardware_type = HardwareType.find( params[:id] )

    render json: hardware_type, status: :ok
  end

  private

  def hardware_type_params
    params.require(:hardware_type).permit(:name)
  end

end
