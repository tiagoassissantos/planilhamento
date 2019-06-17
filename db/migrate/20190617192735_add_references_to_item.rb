class AddReferencesToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference(:lot_items, :sales_order, foreign_key: true)
  end
end
