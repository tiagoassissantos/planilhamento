class AddColumnImageNameToFormats < ActiveRecord::Migration[5.2]
  def change
    add_column :formats, :image_name, :string
  end
end
