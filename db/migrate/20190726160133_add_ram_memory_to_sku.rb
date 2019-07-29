class AddRamMemoryToSku < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    add_column :skus, :ram_memory, :citext
  end
end
