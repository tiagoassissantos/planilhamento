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

  before_create :generate_sku
  after_save :generate_sku_code

  def generate_sku

    return unless self.sku.nil?

    sku = nil

    case hardware_type.id
    when 1
      sku = generate_monitor_sku()
    when 2
      sku = gen_desk_sku()
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
    when 10...+1.0/0.0
      sku = generate_others_sku()
    end
  end

  def generate_monitor_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer,
      model: model, category: category, screen: screen,
      hdmi: hdmi, vga: vga, esata: esata
    )

    p '----------------------------------------------------------------------'
    p sku.errors.full_messages
  end

  def gen_desk_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata, vga_card: vga_card
    )
  end

  def generate_server_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor, hdmi: hdmi, vga: vga
    )
  end

  def generate_notebook_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, processor: processor, screen: screen,
      webcam: webcam, keyboard_type: keyboard_type, wireless: wireless, bluetooth: bluetooth,
      mini_display_port: mini_display_port, hdmi: hdmi, vga: vga, esata: esata,
      bright_keyboard: bright_keyboard, biometric_reader: biometric_reader, vga_card: vga_card
    )
  end

  def generate_celular_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, screen: screen, webcam: webcam
    )
  end

  def generate_tablet_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category, screen: screen, webcam: webcam
    )
  end

  def generate_switch_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      category: category)
  end

  def generate_hd_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_ssd_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model,
      disk_type: disk_type, disk_size: disk_size
    )
  end

  def generate_others_sku()
    self.sku = Sku.find_or_create_by(
      code: nil, hardware_type: hardware_type, manufacturer: model.manufacturer, model: model
    )
  end

  def generate_sku_code
    self.sku.code = self.sku.id
    self.sku.save
  end
end
