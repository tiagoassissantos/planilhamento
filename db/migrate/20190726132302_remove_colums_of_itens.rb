class RemoveColumsOfItens < ActiveRecord::Migration[5.2]
  def change
    remove_column :lot_items, :wireless, :string
    remove_column :lot_items, :mini_display_port, :string
    remove_column :lot_items, :hdmi, :string
    remove_column :lot_items, :vga, :string
    remove_column :lot_items, :esata, :string
  end
end
