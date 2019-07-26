class RemoveColumsOfItens < ActiveRecord::Migration[5.2]
  def change
    remove_column :lot_items, :wireless
    remove_column :lot_items, :mini_display_port
    remove_column :lot_items, :hdmi
    remove_column :lot_items, :vga
    remove_column :lot_items, :esata
  end
end
