class CreateLotItems < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :lot_items do |t|
      t.references :hardware_type, foreign_key: true
      t.references :model, foreign_key: true
      t.citext :ram_memory
      t.citext :serial_number
      t.citext :asset_tag
      t.references :category, foreign_key: true
      t.citext :comments
      t.references :damage_type, foreign_key: true
      t.references :processor, foreign_key: true
      t.references :disk_type, foreign_key: true
      t.references :disk_size, foreign_key: true
      t.citext :parent_id
      t.citext :screen
      t.citext :webcam
      t.references :keyboard_type, foreign_key: true
      t.citext :wireless
      t.citext :bluetooth
      t.citext :mini_display_port
      t.citext :hdmi
      t.citext :vga
      t.citext :esata
      t.citext :bright_keyboard
      t.references :destination, foreign_key: true
      t.citext :bar_code

      t.timestamps
    end
  end
end
