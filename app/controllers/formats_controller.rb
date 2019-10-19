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
