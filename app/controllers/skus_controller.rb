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
    skus = []

    #search for sku_code
    search_sku = Sku.where(code: params[:filter])
    skus = skus + search_sku

    #search for hardware_type
    search_h_type = Sku.joins(:hardware_type).where(hardware_types:{ name: params[:filter]} )
    skus = skus + search_h_type

    #search for manufacturer
    skus_manufacturer = Sku.all
    skus_manufacturer.each do |sku|
      unless sku.model.nil?
        if sku.model.manufacturer.name.downcase == params[:filter].downcase
          skus << sku
        end
      end
    end

    #search for model
    search_model = Sku.joins(:model).where(models:{ name: params[:filter]} )
    skus = skus + search_model

    #search for ram_memory
    search_sku_ram_memory = Sku.where(ram_memory: params[:filter])
    skus = skus + search_sku_ram_memory

    #search for damage_type
    search_damage_types = Sku.all
    verification = true
    search_damage_types.each do |sku|
      unless sku.damage_types.nil?

        sku.damage_types.each do |damage|
          if  verification and damage.name.downcase.include? params[:filter].downcase
            skus << sku
            verification = false
          end
        end
        verification = true
      end
    end

    #search for category
    search_category = Sku.joins(:category).where(categories:{ name: params[:filter]} )
    skus = skus + search_category

    #search for processor
    search_processor = Sku.joins(:processor).where(processors:{ name: params[:filter]} )
    skus = skus + search_processor

    #search for disk_size
    search_disk_size = Sku.joins(:disk_size).where(disk_sizes:{ name: params[:filter]} )
    skus = skus + search_disk_size

    #search for disk_type
    search_disk_type = Sku.joins(:disk_type).where(disk_types:{ name: params[:filter]} )
    skus = skus + search_disk_type

    #search for keyboard
    search_keyboard = Sku.joins(:keyboard_type).where(keyboard_types:{ name: params[:filter]} )
    skus = skus + search_keyboard

    #search for sku_color
    search_sku_color = Sku.where(color: params[:filter])
    skus = skus + search_sku_color

    render json: skus, status: :ok

  end

  def show
    sku = Sku.find_by(id: params[:id])
    render json: sku, status: :ok
  end
end
