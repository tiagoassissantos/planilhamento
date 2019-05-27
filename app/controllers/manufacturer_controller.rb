class ManufacturerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    manufacturers = Manufacturer.all

    render json: manufacturers, status: :ok
  end

  def create
    return unless user_logged?

    manufacturer = Manufacturer.new( manufacturer_params )

    if manufacturer.save
      render json: manufacturer, status: :ok
    else
      render json: {'message': manufacturer.errors.full_message}, status: :internal_server_errir
    end
  end

  def destroy
    return unless user_logged?

    manufacturer = Manufacturer.find( params[:id])

    if manufacturer.delete
      render json: manufacturer, status: 200
    else
      render json: {'message': manufacturer.errors.full_message}, status: :internal_server_errir
    end
  end

  def show
    return unless user_logged?

    manufacturer = Manufacturer.find( params[:id] )

    render json: manufacturer, status: :ok
  end

  def update
    return unless user_logged?

    manufacturer = Manufacturer.find( params[:id] )

    if manufacturer.update( manufacturer_params )
      render json: manufacturer, status: 200
    else 
      render json: {'message': manufacturer.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end
