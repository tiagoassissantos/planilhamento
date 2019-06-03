class AddSkuIdToLotItems < ActiveRecord::Migration[5.2]
  def change
    add_column :lot_items, :sku_id, :integer
  end
end
