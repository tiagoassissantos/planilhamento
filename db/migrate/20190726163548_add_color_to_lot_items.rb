class AddColorToLotItems < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    add_column :lot_items, :color, :citext
  end
end
