class CreateDiskSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :disk_sizes do |t|
      t.string :name

      t.timestamps
    end
  end
end
