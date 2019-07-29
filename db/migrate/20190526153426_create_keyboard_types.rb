class CreateKeyboardTypes < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :keyboard_types do |t|
      t.citext :name

      t.timestamps
    end
  end
end
