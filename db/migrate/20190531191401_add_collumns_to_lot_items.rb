class AddCollumnsToLotItems < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    add_column :lot_items, :biometric_reader, :citext
    add_column :lot_items, :vga_card, :citext
  end
end
