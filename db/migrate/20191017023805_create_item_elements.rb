class CreateItemElements < ActiveRecord::Migration[5.2]
  def change
    create_table :item_elements do |t|
      t.integer :position
      t.string :gauge
      t.integer :quantity
      t.jsonb :format_values
      t.decimal :weight
      t.belongs_to :stage_item
      t.belongs_to :format

      t.timestamps
    end
  end
end
