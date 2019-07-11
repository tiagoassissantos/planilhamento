class CreateLotItemDamageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :lot_item_damage_types do |t|
      t.belongs_to :lot_item, index: true
      t.belongs_to :damage_type, index: true
      t.timestamps
    end
  end
end
