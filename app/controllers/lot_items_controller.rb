class LotItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    lot_items = LotItem.where(lot_id: params[:lot_id])

    render json: lot_items, status: :ok
  end


  def create
    return unless user_logged?

    lot = Lot.find( params[:lot_id] )

    lot_item = lot.lot_items.new( lot_item_params )

    p '--------------------------------------------------'
    p lot_item.to_json

    if lot_item.save
      render json: lot_item, status: :ok
    else
      render json: {'message': lot_item.errors.full_messages}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    lot_item = LotItem.find( params[:id])

    if lot_item.delete
      render json: lot_item, status: 200
    else
      render json: {'message': lot_item.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?

    lot_item = LotItem.find( params[:id] )

    render json: lot_item, status: :ok
  end


  def update
    return unless user_logged?

    lot_item = LotItem.find( params[:id] )

    if lot_item.update( lot_item_params )
      render json: lot_item, status: 200
    else
      render json: {'message': lot_item.errors.full_message}, status: :internal_server_error
    end
  end

  def get_all_skus
    skus = Sku.select('code', 'id').all
    render json: skus, status: 200
  end

  def get_sku
    sku = Sku.find_by(id: params[:sku_id])
    Rails.logger.info('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    Rails.logger.info( sku.to_json )
    Rails.logger.info('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    render json: sku, status: 200
  end


  private

  def lot_item_params
    params.require(:lot_item).permit(
      :hardware_type_id, :model_id, :ram_memory, :serial_number, :asset_tag,
      :category_id, :comments, :damage_type_id, :processor_id, :disk_type_id,
      :disk_size_id, :parent_id, :screen, :webcam, :keyboard_type_id, :wirelles,
      :bluethooth, :mini_display_port, :hdmi, :vga, :esata, :bright_keyboard,
      :destination_id, :bar_code, :biometric_reader, :vga_card
    )
  end
end
