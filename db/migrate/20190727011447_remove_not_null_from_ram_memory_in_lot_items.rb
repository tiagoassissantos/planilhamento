class RemoveNotNullFromRamMemoryInLotItems < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:lot_items, :ram_memory, true)
  end
end
