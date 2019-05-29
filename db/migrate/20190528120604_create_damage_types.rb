class CreateDamageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :damage_types do |t|
      t.string :name
      t.references :hardware_type, foreign_key: true

      t.timestamps
    end
  end
end
