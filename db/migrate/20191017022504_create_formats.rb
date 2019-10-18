class CreateFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :formats do |t|
      t.string :name
      t.integer :sides

      t.timestamps
    end
  end
end
