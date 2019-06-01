class AddCollumnsToLotItems < ActiveRecord::Migration[5.2]
  def change
    add_column :lot_items, :biometric_reader, :string
    add_column :lot_items, :vga_card, :string
  end
end
