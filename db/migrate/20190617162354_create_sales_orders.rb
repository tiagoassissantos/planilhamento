class CreateSalesOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_orders do |t|
      t.column :order_number, :string
      t.timestamps
    end
  end
end
