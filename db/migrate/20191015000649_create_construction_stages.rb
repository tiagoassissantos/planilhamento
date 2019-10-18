class CreateConstructionStages < ActiveRecord::Migration[5.2]
  def change
    create_table :construction_stages do |t|
      t.string :name
      t.string :quantity
      t.string :pavement
      t.belongs_to :construction, index: true
      t.timestamps
    end
  end
end
