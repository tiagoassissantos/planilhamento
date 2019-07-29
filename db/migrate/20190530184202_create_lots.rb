class CreateLots < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.citext :order_number

      t.timestamps
    end
  end
end
