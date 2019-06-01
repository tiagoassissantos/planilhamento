class CreateLotItems < ActiveRecord::Migration[5.2]
  def change
    create_table :lot_items do |t|
      t.references :hardware_type, foreign_key: true
      t.references :model, foreign_key: true
      t.string :ram_memory
      t.string :serial_number
      t.string :asset_tag
      t.references :category, foreign_key: true
      t.string :comments
      t.references :damage_type, foreign_key: true
      t.references :processor, foreign_key: true
      t.references :disk_type, foreign_key: true
      t.references :disk_size, foreign_key: true
      t.string :parent_id
      t.string :screen
      t.string :webcam
      t.references :keyboard_type, foreign_key: true
      t.string :wireless
      t.string :bluetooth
      t.string :mini_display_port
      t.string :hdmi
      t.string :vga
      t.string :esata
      t.string :bright_keyboard
      t.references :destination, foreign_key: true
      t.string :bar_code

      t.timestamps
    end
  end
end
