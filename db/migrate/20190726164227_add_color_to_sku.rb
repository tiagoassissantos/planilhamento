class AddColorToSku < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    add_column :skus, :color, :citext
  end
end
