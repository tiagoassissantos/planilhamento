class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.string :code
      t.string :screen
      t.string :webcam
      t.string :wireless
      t.string :bluetooth
      t.string :mini_display_port
      t.string :hdmi
      t.string :vga
      t.string :esata
      t.string :bright_keyboard
      t.string :biometric_reader
      t.string :vga_card

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
