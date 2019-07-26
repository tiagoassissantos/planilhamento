class AddColorToLotItems < ActiveRecord::Migration[5.2]
  def change
    add_column :lot_items, :color, :string
  end
end
