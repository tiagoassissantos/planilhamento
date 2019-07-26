class AddRamMemoryToSku < ActiveRecord::Migration[5.2]
  def change
    add_column :skus, :ram_memory, :string
  end
end
