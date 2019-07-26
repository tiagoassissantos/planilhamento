class AddNotNullToRamAndSerial < ActiveRecord::Migration[5.2]
  def change
    change_column_null :lot_items, :serial_number, false
    change_column_null :lot_items, :ram_memory, false
  end
end
