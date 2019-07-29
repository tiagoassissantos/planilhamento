class CreateDamageTypes < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :damage_types do |t|
      t.citext :name
      t.references :hardware_type, foreign_key: true

      t.timestamps
    end
  end
end
