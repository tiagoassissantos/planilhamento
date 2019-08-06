class DestinationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?
    destinations = Destination.where.not(name: 'Vendido')
    render json: destinations, status: :ok
  end

  def transfer_destinations
    return unless user_logged?
    destinations = Destination.where.not(name: 'Vendido')
    render json: destinations, status: :ok
  end

  def create
    return unless user_logged?

    verify_destination = Destination.find_by(name: destination_params[:name])
    unless verify_destination.nil?
      render json: {'message': 'Destino já cadastrado'}, status: :internal_server_error
      return
    end

    destination = Destination.new( destination_params )
    if destination.save
      render json: destination, status: :ok
    else
      render json: {'message': destination.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    destination = Destination.find( params[:id])

    if destination.delete
      render json: destination, status: 200
    else
      render json: {'message': destination.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    destination = Destination.find( params[:id] )

    render json: destination, status: :ok
  end


  def update
    return unless user_logged?

    destination = Destination.find( params[:id] )

    if destination.update( destination_params )
      render json: destination, status: 200
    else
      render json: {'message': destination.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def destination_params
    params.require(:destination).permit(:name)
  end
end
