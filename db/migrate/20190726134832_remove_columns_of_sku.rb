class RemoveColumnsOfSku < ActiveRecord::Migration[5.2]
  def change
    remove_column :skus, :wireless
    remove_column :skus, :mini_display_port
    remove_column :skus, :hdmi
    remove_column :skus, :vga
    remove_column :skus, :esata
  end
end
