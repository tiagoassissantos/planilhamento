class FormatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    formats = Format.all.order( :name )
    render json: formats, status: :ok
  end

  def create
    format = Format.new format_params
    format.format_image.attach params[:format_image]

    if format.save
      @registry = format.to_log
      render json: 'ok', status: :ok
    else
      render json: {'message': format.errors.full_messages}, status: :internal_server_error
    end
  end

  def destroy
    format = Format.find(params[:id])

    if format.destroy
      @registry = format.to_log
      render json: 'ok', status: :ok
    end
  end

  def show
    format = Format.find(params[:id])
    render json: format, status: :ok
  end

  def update
    format = Format.find(params[:id])

    if params[:format_image] != 'undefined'
      format.format_image.attach params[:format_image]
    end

    if format.update format_params
      @registry = format.to_log
      render json: 'ok', status: :ok
    else
      render json: {'message': format.errors.full_messages}, status: :internal_server_error
    end
  end

  private

  def format_params
    JSON.parse(params[:format])
  end
end
