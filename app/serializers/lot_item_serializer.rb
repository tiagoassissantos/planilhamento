class LotItemSerializer < ActiveModel::Serializer
  attributes :id, :hardware_type, :model, :ram_memory, :serial_number, :asset_tag,
      :category, :comments, :damage_type, :processor, :disk_type,
      :disk_size, :parent_id, :screen, :webcam, :keyboard_type, :wireless,
      :bluetooth, :mini_display_port, :hdmi, :vga, :esata, :bright_keyboard,
      :destination, :bar_code, :biometric_reader, :vga_card

  has_one :model

  def hardware_type
    return object.hardware_type.name
  end

  #def model
  #  return object.model.name
  #end

  def category
    return object.category.name unless object.category.nil?
  end

  def damage_type
    return object.damage_type.name unless object.damage_type.nil?
  end

  def processor
    return object.processor.name unless object.processor.nil?
  end

  def disk_type
    return object.disk_type.name unless object.disk_type.nil?
  end

  def disk_size
    return object.disk_size.name unless object.disk_size.nil?
  end

  def keyboard_type
    return object.keyboard_type.name unless object.keyboard_type.nil?
  end

  def destination
    return object.destination.name
  end
end
