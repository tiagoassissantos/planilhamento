class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.belongs_to :construction, index: true
      t.timestamps
    end
  end
end


