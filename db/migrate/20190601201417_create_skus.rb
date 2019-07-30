class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    create_table :skus do |t|
      t.citext :code
      t.citext :screen
      t.citext :webcam
      t.citext :wireless
      t.citext :bluetooth
      t.citext :mini_display_port
      t.citext :hdmi
      t.citext :vga
      t.citext :esata
      t.citext :bright_keyboard
      t.citext :biometric_reader
      t.citext :vga_card

      t.references :hardware_type, foreign_key: true
      t.references :manufacturer, foreign_key: true
      t.references :model, foreign_key: true
      t.references :category, foreign_key: true
      t.references :damage_type, foreign_key: true
      t.references :processor, foreign_key: true
      t.references :disk_size, foreign_key: true
      t.references :disk_type, foreign_key: true
      t.references :keyboard_type, foreign_key: true

      t.timestamps
    end
  end
end
