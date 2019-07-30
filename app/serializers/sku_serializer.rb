class SkuSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :code, :hardware_type, :manufacturer, :model, :ram_memory,
             :archive, :damages, :category, :processor, :disk_size, :disk_type, :webcam, :keyboard_type, :bluetooth, :bright_keyboard, :biometric_reader, :vga_card, :color

  has_one :hardware_type
  #has_one :manufacturer
  has_one :model
  has_one :archive
  has_one :category
  has_one :processor
  has_one :disk_size
  has_one :disk_type
  has_one :keyboard_type


  def hardware_type
    return object.hardware_type.name
  end

  def manufacturer
    return object.model.manufacturer.name
  end

  def model
    return object.model.name
  end

  def category
    unless object.category.nil?
      return object.category.name
    else
      return nil
    end
  end

  def damages
    dams = []
    object.damage_types.each do |damage|
      dams << damage.name
    end
    return dams
  end

  def processor
    unless object.processor.nil?
      return object.processor.name
    else
      return nil
    end
  end

  def archive

    if object.archive.attached?
      Rails.logger.info('+++++++++++++++++++++++++')
      Rails.logger.info(ENV["url"])
      Rails.logger.info('+++++++++++++++++++++++++')
      url = 'http://'+ ENV["url"] + rails_blob_path( object.archive, disposition: "attachment" )
      return url
    else
      return 'false'
    end
  end

  def disk_size
    unless object.disk_size.nil?
      return object.disk_size.name
    else
      return nil
    end
  end

  def disk_type
    unless object.disk_type.nil?
      return object.disk_type.name
    else
      return nil
    end
  end

  def webcam
    case object.webcam
    when '1'
      return 'Sim'
    when '0'
      return 'Não'
    else
      return nil
    end
  end

  def keyboard_type
    unless object.keyboard_type.nil?
      return object.keyboard_type.name
    else
      return nil
    end
  end

  def bluetooth
    case object.bluetooth
    when '1'
      return 'Sim'
    when '0'
      return 'Não'
    else
      return nil
    end
  end

  def bright_keyboard
    case object.bright_keyboard
    when '1'
      return 'Sim'
    when '0'
      return 'Não'
    else
      return nil
    end
  end

  def biometric_reader
    case object.biometric_reader
    when '1'
      return 'Sim'
    when '0'
      return 'Não'
    else
      return nil
    end
  end

  def vga_card
    case object.vga_card
    when '1'
      return 'Sim'
    when '0'
      return 'Não'
    else
      return nil
    end
  end
end


