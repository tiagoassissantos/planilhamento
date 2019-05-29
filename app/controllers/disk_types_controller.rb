class DiskTypesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    disk_types = DiskType.all

    render json: disk_types, status: :ok
  end


  def create
    return unless user_logged?

    disk_type = DiskType.new( disk_type_params )

    if disk_type.save
      render json: disk_type, status: :ok
    else
      render json: {'message': disk_type.errors.full_message}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    disk_type = DiskType.find( params[:id])

    if disk_type.delete
      render json: disk_type, status: 200
    else
      render json: {'message': disk_type.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    disk_type = DiskType.find( params[:id] )

    render json: disk_type, status: :ok
  end


  def update
    return unless user_logged?

    disk_type = DiskType.find( params[:id] )

    if disk_type.update( disk_type_params )
      render json: disk_type, status: 200
    else
      render json: {'message': disk_type.errors.full_message}, status: :internal_server_error
    end
  end


  private

  def disk_type_params
    params.require(:disk_type).permit(:name)
  end
end
