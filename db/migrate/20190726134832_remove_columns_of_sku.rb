class RemoveColumnsOfSku < ActiveRecord::Migration[5.2]
  def change
    remove_column :skus, :wireless, :string
    remove_column :skus, :mini_display_port, :string
    remove_column :skus, :hdmi, :string
    remove_column :skus, :vga, :string
    remove_column :skus, :esata, :string
  end
end
