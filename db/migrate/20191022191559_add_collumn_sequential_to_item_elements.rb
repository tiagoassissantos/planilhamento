class AddCollumnSequentialToItemElements < ActiveRecord::Migration[5.2]
  def change
    add_column :item_elements, :sequential, :integer
  end
end
