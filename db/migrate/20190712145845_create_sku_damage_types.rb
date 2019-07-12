class CreateSkuDamageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :sku_damage_types do |t|
      t.belongs_to :sku, index: true
      t.belongs_to :damage_type, index: true
      t.timestamps
    end
  end
end
