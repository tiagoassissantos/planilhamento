class CreateDiskSizes < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :disk_sizes do |t|
      t.citext :name

      t.timestamps
    end
  end
end
