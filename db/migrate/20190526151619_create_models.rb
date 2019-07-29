class CreateModels < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :models do |t|
      t.citext :name
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end
  end
end
