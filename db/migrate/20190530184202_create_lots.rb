class CreateLots < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.string :order_number

      t.timestamps
    end
  end
end
