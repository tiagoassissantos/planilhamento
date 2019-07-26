class AddColorToSku < ActiveRecord::Migration[5.2]
  def change
    add_column :skus, :color, :string
  end
end
