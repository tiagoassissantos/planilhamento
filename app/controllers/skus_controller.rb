class SkusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    skus = Sku.all
    render json: skus, status: 200
  end

  def update
    sku = Sku.find_by(id: params[:id])
    sku.archive.attach(params[:archive_file])
    render json: {'message': 'Arquivo enviado com sucesso.'}, status: :ok
  rescue => e
    Rails.logger.error '---------------------- ERROR update image ----------------------'
    Rails.logger.error e.message
    Rails.logger.error e.backtrace
  end

  def delete_archive
    sku = Sku.find(params[:sku_id])
    if sku.archive.purge
      render json: {'message': 'Arquivo removido com sucesso'}, status: :ok
    end
  end

  def query_sku
    skus = Sku.search( params[:filter])
    render json: skus, status: :ok
  end

  def show
    sku = Sku.find_by(id: params[:id])
    render json: sku, status: :ok
  end
end
