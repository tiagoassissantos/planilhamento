class AddNotNullToBarCode < ActiveRecord::Migration[5.2]
  def change
    change_column_null :lot_items, :bar_code, false
  end
end
