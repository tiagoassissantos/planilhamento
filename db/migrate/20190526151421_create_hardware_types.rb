class CreateHardwareTypes < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :hardware_types do |t|
      t.citext :name
      t.citext :description

      t.timestamps
    end
  end
end
