class CreateTableLotItemDamageType < ActiveRecord::Migration[5.2]
  def change
    create_table :table_lot_item_damage_types do |t|
      t.belongs_to :damage_type, index: true
      t.belongs_to :lot_item, index: true
    end
  end
end
