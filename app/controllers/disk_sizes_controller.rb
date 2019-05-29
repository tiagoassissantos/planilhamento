class DiskSizesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    disk_sizes = DiskSize.all

    render json: disk_sizes, status: :ok
  end


  def create
    return unless user_logged?

    disk_size = DiskSize.new( disk_size_params )

    if disk_size.save
      render json: disk_size, status: :ok
    else
      render json: {'message': disk_size.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    disk_size = DiskSize.find( params[:id])

    if disk_size.delete
      render json: disk_size, status: 200
    else
      render json: {'message': disk_size.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    disk_size = DiskSize.find( params[:id] )

    render json: disk_size, status: :ok
  end


  def update
    return unless user_logged?

    disk_size = DiskSize.find( params[:id] )

    if disk_size.update( disk_size_params )
      render json: disk_size, status: 200
    else
      render json: {'message': disk_size.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def disk_size_params
    params.require(:disk_size).permit(:name)
  end
end
