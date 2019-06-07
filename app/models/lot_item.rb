class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :hardware_type
  belongs_to :model
  belongs_to :destination
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  belongs_to :damage_type, optional: true
  belongs_to :sku, optional: true

  before_save :generate_sku

  def generate_sku

    return unless self.sku.nil?

    sku = nil

    case hardware_type.id
    when 1
      sku = generate_monitor_sku()
    when 2
      sku = generate_desktop_Sku()
    when 3
      sku = generate_server_sku()
    when 4
      sku = generate_notebook_sku()
    when 5
      sku = generate_celular_sku()
    when 6
      sku = generate_tablet_sku()
    when 7
      sku = generate_switch_sku()
    when 8
      sku = generate_hd_sku()
    when 9
      sku = generate_ssd_sku()
    when 10
      sku = generate_others_sku()
    end
  end

  def generate_monitor_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s
    code += screen
    code += hdmi[0,1]
    code += vga[0,1]
    code += esata[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer,
      model: model, category: category, damage_type: damage_type, screen: screen,
      hdmi: hdmi, vga: vga, esata: esata
    )

    p '----------------------------------------------------------------------'
    p sku.errors.full_messages
  end

  def generate_desktop_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s
    code += processor.id.to_s
    code += mini_display_port[0,1]
    code += hdmi[0,1]
    code += vga[0,1]
    code += esata[0,1]
    code += vga_card[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, damage_type: damage_type, processor: processor,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata, vga_card: vga_card
    )
  end

  def generate_server_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    #code += damage_type.id.to_s
    code += processor.id.to_s
    code += hdmi[0,1]
    code += vga[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor, hdmi: hdmi, vga: vga
    )
  end

  def generate_notebook_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s
    code += processor.id.to_s
    code += screen
    code += webcam[0,1]
    code += keyboard_type.id.to_s
    code += wireless[0,1]
    code += bluetooth[0,1]
    code += mini_display_port[0,1]
    code += hdmi[0,1]
    code += vga[0,1]
    code += esata[0,1]
    code += bright_keyboard.id.to_s
    code += biometric_reader[0,1]
    code += vga_card[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, damage_type: damage_type, processor: processor, screen: screen,
      webcam: webcam, keyboard_type: keyboard_type, wireless: wireless, bluetooth: bluetooth,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata,
      bright_keyboard: bright_keyboard, biometric_reader: biometric_reader, vga_card: vga_card
    )
  end

  def generate_celular_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s
    code += screen
    code += webcam[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, damage_type: damage_type, screen: screen, webcam: webcam
    )
  end

  def generate_tablet_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s
    code += screen
    code += webcam[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, damage_type: damage_type, screen: screen, webcam: webcam
    )
  end

  def generate_switch_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_type.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, damage_type: damage_type
    )
  end

  def generate_hd_sku
    code = ''
    code += hardware_type.name[0,3]
    code += disk_type.id.to_s
    code += disk_size.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_ssd_sku
    code = ''
    code += hardware_type.name[0,3]
    code += disk_type.id.to_s
    code += disk_size.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_others_sku
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model
    )
  end
end
