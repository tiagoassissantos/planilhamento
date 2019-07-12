class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :sales_order, optional: true
  belongs_to :hardware_type
  belongs_to :model
  belongs_to :destination
  belongs_to :processor, optional: true
  belongs_to :disk_type, optional: true
  belongs_to :disk_size, optional: true
  belongs_to :keyboard_type, optional: true
  belongs_to :category, optional: true
  belongs_to :sku, optional: true
  has_many :lot_item_damage_types
  has_many :damage_types, :through => :lot_item_damage_types

  before_save :generate_sku

  def generate_sku

    return unless self.sku.nil?

    sku = nil
    damage_code = generate_code_damage()

    case hardware_type.id
    when 1
      sku = generate_monitor_sku(damage_code)
    when 2
      sku = gen_desk_sku(damage_code)
    when 3
      sku = generate_server_sku(damage_code)
    when 4
      sku = generate_notebook_sku(damage_code)
    when 5
      sku = generate_celular_sku(damage_code)
    when 6
      sku = generate_tablet_sku(damage_code)
    when 7
      sku = generate_switch_sku(damage_code)
    when 8
      sku = generate_hd_sku(damage_code)
    when 9
      sku = generate_ssd_sku(damage_code)
    when 10...+1.0/0.0
      sku = generate_others_sku(damage_code)
    end
  end

  def generate_code_damage
    code = ''
    damage_types.each do |damage|
      code += damage.id.to_s
    end
    return code
  end

  def insert_damage_sku(sku, damage_types)
    damage_types.each do |damage|
      sku.damage_types << damage
    end
    sku.save
  end

  def generate_monitor_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
    code += screen
    code += hdmi[0,1]
    code += vga[0,1]
    code += esata[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer,
      model: model, category: category, screen: screen,
      hdmi: hdmi, vga: vga, esata: esata
    )

    insert_damage_sku( self.sku, damage_types)

    p '----------------------------------------------------------------------'
    p sku.errors.full_messages
  end

  def gen_desk_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
    code += processor.id.to_s
    code += mini_display_port[0,1]
    code += hdmi[0,1]
    code += vga[0,1]
    code += esata[0,1]
    code += vga_card[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata, vga_card: vga_card
    )
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_server_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
    code += processor.id.to_s
    code += hdmi[0,1]
    code += vga[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor, hdmi: hdmi, vga: vga
    )
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_notebook_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
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
    code += bright_keyboard.to_s
    code += biometric_reader[0,1]
    code += vga_card[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor, screen: screen,
      webcam: webcam, keyboard_type: keyboard_type, wireless: wireless, bluetooth: bluetooth,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata,
      bright_keyboard: bright_keyboard, biometric_reader: biometric_reader, vga_card: vga_card
    )
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_celular_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
    code += screen
    code += webcam[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, screen: screen, webcam: webcam
    )
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_tablet_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code
    code += screen
    code += webcam[0,1]

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, screen: screen, webcam: webcam
    )
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_switch_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += category.id.to_s
    code += damage_code

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category)
    insert_damage_sku( self.sku, damage_types)
  end

  def generate_hd_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += disk_type.id.to_s
    code += disk_size.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_ssd_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s
    code += disk_type.id.to_s
    code += disk_size.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_others_sku(damage_code)
    code = ''
    code += hardware_type.name[0,3]
    code += model.manufacturer.id.to_s
    code += model.id.to_s

    self.sku = Sku.find_or_create_by(
      code: code, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model
    )
  end
end
