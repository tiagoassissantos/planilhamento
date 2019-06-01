class AddCollumnLotIdToLotItems < ActiveRecord::Migration[5.2]
  def change
    add_column :lot_items, :lot_id, :integer
  end
end
