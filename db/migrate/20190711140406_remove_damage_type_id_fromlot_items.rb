class RemoveDamageTypeIdFromlotItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :lot_items, :damage_type_id, :integer
  end
end
