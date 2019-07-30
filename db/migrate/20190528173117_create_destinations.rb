class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :destinations do |t|
      t.citext :name

      t.timestamps
    end
  end
end
