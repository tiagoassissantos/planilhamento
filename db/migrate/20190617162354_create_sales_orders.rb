class CreateSalesOrders < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :sales_orders do |t|
      t.column :order_number, :citext
      t.timestamps
    end
  end
end
